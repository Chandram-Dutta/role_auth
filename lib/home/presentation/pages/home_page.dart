import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:role_auth/authentication/presentation/pages/login_page.dart';
import 'package:role_auth/authentication/repository/firebase_auth_repository.dart';
import 'package:role_auth/home/repository/firebase_user_type_repository.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Role Based Auth"),
        actions: [
          IconButton(
            onPressed: () async {
              await ref.watch(firebaseAuthRepositoryProvider).logout();
              if (context.mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                  (route) => false,
                );
              }
            },
            icon: const Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: ref
          .watch(
            getUserTypeProvider(
              ref.watch(firebaseAuthRepositoryProvider).currentUser!.uid,
            ),
          )
          .when(
            data: (data) {
              switch (data["type"]) {
                case "vendor":
                  return const Center(
                    child: Text("You are a vendor"),
                  );
                case "customer":
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("You are a customer"),
                        data["vendorEmail"] != ""
                            ? Text("You are assigned to ${data["vendorEmail"]}")
                            : const SizedBox()
                      ],
                    ),
                  );
                case "admin":
                  return FirestoreListView(
                    query: ref.watch(firebaseUserTypeProvider).getUserList(),
                    itemBuilder: (context, snapshot) {
                      Map<String, dynamic> user = snapshot.data();
                      return Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ListTile(
                          title: Text(user["email"]),
                          subtitle: Text(user["type"].toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              user["type"] == "customer"
                                  ? IconButton(
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return SizedBox(
                                              height: 400,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  children: [
                                                    const Text("Add Vendor"),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    FirestoreListView(
                                                      shrinkWrap: true,
                                                      query: ref
                                                          .watch(
                                                              firebaseUserTypeProvider)
                                                          .getUserListByType(
                                                              "vendor"),
                                                      itemBuilder: (context,
                                                          snapshotchild) {
                                                        return ListTile(
                                                          onTap: () async {
                                                            await ref
                                                                .watch(
                                                                    firebaseUserTypeProvider)
                                                                .addVendor(
                                                                    snapshot.id,
                                                                    snapshotchild
                                                                            .data()[
                                                                        "email"]);
                                                            if (context
                                                                .mounted) {
                                                              Navigator.pop(
                                                                  context);
                                                            }
                                                          },
                                                          title: Text(
                                                            snapshotchild
                                                                    .data()[
                                                                "email"],
                                                          ),
                                                        );
                                                      },
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                          CupertinoIcons.person_add_solid),
                                    )
                                  : const SizedBox(),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  showCupertinoDialog(
                                    context: context,
                                    builder: (context) => CupertinoAlertDialog(
                                      title: const Text("Change Role"),
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            CupertinoButton(
                                              onPressed: () async {
                                                await ref
                                                    .watch(
                                                        firebaseUserTypeProvider)
                                                    .changeUserType(
                                                      snapshot.id,
                                                      "admin",
                                                    );
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("Admin"),
                                            ),
                                            CupertinoButton(
                                              onPressed: () async {
                                                await ref
                                                    .watch(
                                                        firebaseUserTypeProvider)
                                                    .changeUserType(
                                                      snapshot.id,
                                                      "vendor",
                                                    );
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("Vendor"),
                                            ),
                                            CupertinoButton(
                                              onPressed: () async {
                                                await ref
                                                    .watch(
                                                        firebaseUserTypeProvider)
                                                    .changeUserType(
                                                      snapshot.id,
                                                      "customer",
                                                    );
                                                if (context.mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: const Text("Customer"),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        CupertinoDialogAction(
                                          child: const Text("Back"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
              }
              return null;
            },
            error: (err, stack) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(err.toString()),
                  Text(stack.toString()),
                ],
              ),
            ),
            loading: () => const Center(
              child: CupertinoActivityIndicator(),
            ),
          ),
    );
  }
}
