import 'package:e_commerce_store/core/constants.dart';
import 'package:e_commerce_store/presentation/profile/widgets/profile_circleavathar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'functions/profile_functions.dart';
import 'widgets/background_design.dart';
import 'widgets/profile_items.dart';

class ScreenProfile extends StatelessWidget {
  const ScreenProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: [
                  const BagroundDesign(),
                  const ProfieCircleAvathar(),
                  Positioned(
                    left: 0,
                    child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new)),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                        onPressed: () =>
                            ProfileFunctions().exitdialogBuilder(context),
                        icon: const Icon(Icons.logout_outlined)),
                  )
                ],
              ),
              Text(
                userEmail,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                userName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              constSizedBox20,
              const ProfileItems()
            ],
          ),
        ),
      ),
    );
  }
}

final String userEmail = FirebaseAuth.instance.currentUser!.email!;
final String userName = FirebaseAuth.instance.currentUser!.displayName ?? '';
