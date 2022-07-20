import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTransaction;

  TransactionList({
    Key? key,
    required this.transactions,
    required this.deleteTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: ((context, constraints) {
              return Column(
                children: [
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: constraints.maxHeight * .6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            }),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              final tx = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          '\$${tx.amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tx.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(tx.date),
                  ),
                  trailing: mediaQuery.size.width > 400
                      ? TextButton.icon(
                          icon: Icon(Icons.delete),
                          onPressed: () => deleteTransaction(tx.id),
                          label: Text('Delete'),
                        )
                      : IconButton(
                          onPressed: () => deleteTransaction(tx.id),
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
