#[contract]
mod UtilsContract {

    use starknet::ContractAddress;
    use array::ArrayTrait;
    use option::OptionTrait;

    #[abi]
    trait IERC20 {
        fn balanceOf(account : ContractAddress) -> u256;
    }

    #[view]
    fn sum_balances(account : ContractAddress, erc20 : Array<ContractAddress>) -> u256 {
        let mut erc20_ = erc20;
        let mut sum = 0;
        loop {
            if erc20_.len() == 0 {
                    break ();
            };
            let balance = IERC20Dispatcher{
                contract_address: erc20_.pop_front().expect('iteration error')
            }.balanceOf(account);
            sum += balance;
        };
        sum
    }

}
