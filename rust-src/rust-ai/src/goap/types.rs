use bitflags::{Flags};

pub struct Conditions<F: Flags + Clone> {
    pub equals: F,
    pub negates: F
}

/// a generic trait that must be implemented by any GoapAction
pub trait GoapAction<F: Flags + Clone> {
    fn get_id(&self) -> usize;
    fn get_name(&self) -> &str;
    fn get_post_conditions(&self) -> &Conditions<F>;
    fn get_preconditions(&self) -> &Conditions<F>;
    fn get_cost(&self) -> u32;
}

