import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:top_up_app/view/commonWidgets/custom_text_field.dart';

import '../../../../common/colors.dart';
import '../../../../viewModels/beneficiary_view_model.dart';

class AddBeneficiaryWidget extends StatefulWidget {
  const AddBeneficiaryWidget({super.key});

  @override
  State<AddBeneficiaryWidget> createState() => _AddBeneficiaryWidgetState();
}

class _AddBeneficiaryWidgetState extends State<AddBeneficiaryWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController? beneficiaryNameController;
  TextEditingController? beneficiaryNumberController;
  TextEditingController? countryCodeController;

  @override
  void initState() {
    beneficiaryNameController = TextEditingController(text: "");
    beneficiaryNumberController = TextEditingController(text: "");
    countryCodeController = TextEditingController(text: "+971");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BeneficiaryViewModel>(
        builder: (context, beneficiaryViewModel, child) {
      return beneficiaryViewModel.isRegisteringNewBeneficiary
          ? Center(
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  CircularProgressIndicator(
                    color: MyColors.activeColor,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Registering a beneficiary..",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add a new Beneficiary",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        beneficiaryViewModel.addANewBeneficiary(false);
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: MyColors.activeColor,
                        padding: EdgeInsets.zero,
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.close_rounded,
                          ),
                          Text(
                            "Cancel",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        hint: "Enter the nickname",
                        charLength: 20,
                        textController: beneficiaryNameController!,
                        icon: Icons.person,
                        validation: (value) {
                          if (value!.trim().isEmpty) {
                            return "Please enter the nickname";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            flex: 300,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: MyColors.activeColor,
                                ),
                                borderRadius: BorderRadius.circular(05),
                              ),
                              child: CountryCodePicker(
                                showFlag: true,
                                onChanged: (countryCode) {
                                  setState(() {
                                    countryCodeController!.text =
                                        countryCode.dialCode.toString();
                                  });
                                },
                                initialSelection: 'AE',
                                flagWidth: 20,
                                favorite: const ['+971', 'AE'],
                                showCountryOnly: false,
                                showOnlyCountryWhenClosed: false,
                                showFlagMain: true,
                                alignLeft: false,
                              ),
                            ),
                          ),
                          const Expanded(flex: 20, child: SizedBox()),
                          Expanded(
                            flex: 680,
                            child: CustomTextField(
                              hint: "Enter the phone number",
                              charLength: 9,
                              isNumber: true,
                              textController: beneficiaryNumberController!,
                              icon: Icons.phone,
                              validation: (value) {
                                if (value!.trim().isEmpty) {
                                  return "Please enter phone number";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            beneficiaryViewModel.registerBeneficiary(
                              beneficiaryName: beneficiaryNameController!.text,
                              countryCode: countryCodeController!.text,
                              phoneNumber: beneficiaryNumberController!.text,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.activeColor,
                            foregroundColor: MyColors.whiteColor,
                            elevation: 5),
                        child: const Text("Register Beneficiary"),
                      )
                    ],
                  ),
                ),
              ],
            );
    });
  }

  @override
  void dispose() {
    beneficiaryNameController!.dispose();
    beneficiaryNumberController!.dispose();
    countryCodeController!.dispose();
    super.dispose();
  }
}
