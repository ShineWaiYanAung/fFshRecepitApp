import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:kg6_project/Bloc/cart_bloc.dart';
import 'package:kg6_project/Screen/fish_invoice_detai.dart';

import '../CubitBloc/usernameHander_cubit.dart';
import '../HiveTransaction/boxes.dart';
import '../HiveTransaction/transaction.dart';
import '../Theme/app_color.dart';


class InvoiceHistory extends StatefulWidget {
  const InvoiceHistory({super.key});

  @override
  State<InvoiceHistory> createState() => _InvoiceHistoryState();
}

class _InvoiceHistoryState extends State<InvoiceHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.secondColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios,color: Colors.white,size: 35,),
        ),
        title: const Text(
          "ဘောင်ချာမှတ်တမ်း",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800,color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ValueListenableBuilder<Box<Transaction>>(
        valueListenable: Boxes.getTransactions().listenable(),
        builder: (context, box, _) {
          final invoices = box.values.toList().cast<Transaction>();
          if (invoices.isEmpty) {
            return const Center(
              child: Text("ဘောင်ချာမှတ်တမ်းမမှတ်ကသေးပါ",style: TextStyle(color: Colors.grey,fontSize: 20,),),
            );
          } else {
            return ListView.builder(
                itemCount: invoices.length,
                itemBuilder: (context, int index) {
                  final invoice = invoices[index];
                  final fish = invoice.invoice;
                  final number = (index + 1).toString();
                  final date = DateFormat.yMMMd().format(invoice.createdDate);

                  return InkWell(
                    onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context) => FishDetailScreen(items: fish),)),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text(number),
                        ),
                        title: Align(
                          alignment: Alignment.center,
                          child: Text(date),
                        ),
                        trailing: IconButton(
                          color: Colors.red,
                          onPressed: (){
                            final cubitDeletedInvoice=   context.read<CartBloc>();
                            cubitDeletedInvoice.deleteTransaction(invoice);
                          }, icon: Icon(Icons.delete),
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
