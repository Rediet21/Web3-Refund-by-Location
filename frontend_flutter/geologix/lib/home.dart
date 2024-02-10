import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geologix/utils.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const snackBar = SnackBar(
  content: Text('Yay! A SnackBar!'),
);

class _HomeScreenState extends State<HomeScreen> {
  final String rpcUrl = "";

  final String contractABI = "";

  // final EthereumAddress contractAddress = "";
  //  EthereumAddress.fromHex("");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var sizeH = size.height;
    var sizeW = size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Padding(
      //     padding: EdgeInsets.only(left: 8.0),
      //     child: Text("Geologix"),
      //   ),
      //   actions: [
      //     IconButton(onPressed: () {}, icon: const Icon(Icons.notifications))
      //   ],
      // ),
      body: SafeArea(
        child: Container(
          // height: sizeH,
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: const Text(
                  " Welcome, Rediet",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xFF666EF5)),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: const [
                        Text(
                          "Total Earnings: ",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(width: 10),
                        Text(
                          "48000 Eth",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Text(
                          "rewards:",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "3",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: const [
                        Text(
                          "penalities:",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(width: 16),
                        Text(
                          "1",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    onPressed: () async {
                      await _onSendLocation(context);
                    },
                    child: Text('Send Location'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Color(0xFF666EF5),
                      backgroundColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }

  _onSendLocation(BuildContext context) async {
    try {
      var currentLocation = await Utils.getCurrentLocation();
      if (currentLocation == null) {
        final snackBar = SnackBar(
          content: const Text('Error getting current location'),
          backgroundColor: (Colors.red.shade200),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        final client = Web3Client(rpcUrl, Client());
        final contract = DeployedContract(
          ContractAbi.fromJson(contractABI, 'ContractName'),
           contractAddress,
         );

         final credentials =
             await client.credentialsFromPrivateKey('YOUR_PRIVATE_KEY');
         final ethFunction = contract.function('sendGPSReading');

         final result = await client.sendTransaction(
           credentials,
           Transaction.callContract(
             contract: contract,
             function: ethFunction,
             parameters: [
               BigInt.from(currentLocation.longitude * 10e6),
               BigInt.from(currentLocation.latitude * 10e6),
               BigInt.from(DateTime.now().millisecondsSinceEpoch),
             ],
           ),
           fetchChainIdFromNetworkId: true,
         );
        final snackBar = SnackBar(
          content: const Text('Sending location successful'),
          backgroundColor: (Colors.green.shade200),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

         print('Transaction result: ${result}');
      }
    } catch (e) {
      final snackBar = SnackBar(
        content: Text('Error sending location: $e'),
        backgroundColor: (Colors.red.shade200),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
