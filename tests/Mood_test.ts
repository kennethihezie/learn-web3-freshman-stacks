
import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v1.4.2/index.ts';
import { assertEquals } from 'https://deno.land/std@0.170.0/testing/asserts.ts';

Clarinet.test({
    name: "set Mood variable",
    async fn(chain: Chain, accounts: Map<string, Account>) {
        //get the deployer account
        let deployer = accounts.get('deployer')

        let block = chain.mineBlock([
            // Generate a contract call to set-mood from the deployer address.
            Tx.cotractCall("mood", "set-mood", ["Learning"], deployer.address)
        ])

        let [receipt] = block.receipts
        receipt.result.expectOk().expectStringUtf8("Learning")

        
      //Get the mood value
       let mood = chain.callReadOnlyFn("mood", "get-mood", [
        types.principal(deployer.address)
      ], deployer.address)       

      //Assert that the returned result is a u1
      mood.result.expectStringUtf8("Learning")
    },
});
