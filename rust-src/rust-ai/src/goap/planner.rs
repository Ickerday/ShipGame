// Based on work of Samuel Loretan <tynril@gmail.com> – see: https://github.com/tynril/rgoap/blob/master/src/lib.rs

use std::fmt::Debug;
use std::hash::{Hash, Hasher};
use bitflags::Flags;
use crate::goap::types::{GoapAction, Conditions};


#[derive(Debug)]
pub(crate) struct PlanNode<'a, T: GoapAction<F>, F: Flags + std::clone::Clone>
{
    current_state: F,
    pub(crate) action: Option<&'a T>,
}

impl<T: GoapAction<F>, F: Flags + std::clone::Clone> Clone for PlanNode<'_, T, F>{
    fn clone(&self) -> Self {
        PlanNode {
            current_state: self.current_state.clone(),
            action: self.action.clone()
        }
    }
}


impl<T: GoapAction<F>, F: Flags + std::clone::Clone> PartialEq<Self> for PlanNode<'_, T, F> {
    fn eq(&self, other: &Self) -> bool {
        if self.action.is_some() && other.action.is_some() {
            return self.action.unwrap().get_id() == other.action.unwrap().get_id();
        }
        false
    }
}


impl<T: GoapAction<F>, F: Flags + std::clone::Clone + Eq> Eq for PlanNode<'_, T, F> { }

impl<'a, 'b: 'a, T: GoapAction<F>, F: Flags + std::clone::Clone + Hash> Hash for PlanNode<'a, T, F> {
    fn hash<H: Hasher>(&self, state: &mut H) {
        if let Some(action) = self.action {
            action.get_name().hash(state);
        }
        self.current_state.hash(state);
    }
}

impl<'a, T: GoapAction<F>, F: Flags + std::clone::Clone> PlanNode<'a, T, F> {
    pub(crate) fn initial(initial_state: &'a F) -> PlanNode<'a, T, F> {
        PlanNode {
            current_state: initial_state.clone(),
            action: None,
        }
    }
    fn child(parent_state: F, action: &'a T) -> PlanNode<'a, T, F> {
        let conditions = action.get_post_conditions();
        let child = PlanNode {
            // Applies the post-condition of the action applied on our parent state.
            current_state: parent_state.union(conditions.equals.clone()).difference(conditions.negates.clone()),
            action: Some(action)
        };

        child
    }
    /// Returns all possible nodes from this current state, along with the cost to get there.
    pub(crate) fn possible_next_nodes(&self,
                                      actions: &'a Vec<T>,
    ) -> Vec<(PlanNode<'a, T, F>, u32)> {
        let actions = actions.iter().filter_map(
            |action|
                {
                    // todo – check for procedural preconditions
                    if self.matches_target(action.get_preconditions()) {
                        let action_cost: u32 = action.get_cost( );
                        return Some((PlanNode::child(self.current_state.clone(), action), action_cost));
                    }
                    None
                }
        ).collect();
        actions
    }

    /// Count the number of states in this node that aren't matching the given target.
    pub(crate) fn mismatch_count(&self, target: &Conditions<F>) -> u32 {

        let mut count: u32 = 0;
        for flag in target.equals.iter() {
            if self.current_state.contains(flag) {
                continue
            }
            count += 1
        }
        for flag in target.negates.iter() {
            if !self.current_state.contains(flag) {
                continue
            }
            count += 1
        }
        count
    }

    /// Returns `true` if the current node is a full match for the given target.
    pub(crate) fn matches_target(&self, target: &Conditions<F>) -> bool {
        self.mismatch_count(target) == 0
    }
}
