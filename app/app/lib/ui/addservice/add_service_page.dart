import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:resources/resources.dart';
import 'package:app/ui/addservice/bloc/addservice.dart';

@RoutePage(name: 'AddServiceRoute')
class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key, required this.shopId});
  final String shopId;
  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final List<String> dropdownItems = [
    "Hair",
    "Nails",
    "Skin",
    "Spa",
    "Makeup",
    "Lips"
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddServiceBloc(
        GetIt.I.get<CreateServiceUseCase>()
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.current.addservice),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocBuilder<AddServiceBloc, AddServiceState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInputField(
                      label: S.current.servicename,
                      hintText: S.current.insert_servicename,
                      onChanged: (value) {
                        context
                            .read<AddServiceBloc>()
                            .add(NameChangedEvent(name: value));
                      },
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        BlocBuilder<AddServiceBloc, AddServiceState>(
                          builder: (context, state) {
                            return DropdownButton<String>(
                              value: state.style,
                              hint: Text(S.current.catalog),
                              items: dropdownItems.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(item),
                                );
                              }).toList(),
                              onChanged: (value){

                              }, 
                            );
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: CustomInputField(
                            type: TextInputType.number,
                            label: S.current.duration,
                            hintText: S.current.minute,
                            onChanged: (value) {
                              context.read<AddServiceBloc>().add(
                                  DurationChangedEvent(
                                      duration: int.parse(value)));
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        // Handle image selection
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.image, size: 50, color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomInputField(
                      type: TextInputType.number,
                      label: S.current.service_price,
                      hintText: S.current.insert_serviceprice,
                      suffixText: S.current.money,
                      onChanged: (value) {
                        context
                            .read<AddServiceBloc>()
                            .add(PriceChangedEvent(price: double.parse(value)));
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomInputField(
                      type: TextInputType.number,
                      label: S.current.employeecando,
                      hintText: S.current.inser_employeecando,
                      onChanged: (value) {
                        context
                            .read<AddServiceBloc>()
                            .add(PriceChangedEvent(price: double.parse(value)));
                      },
                    ),
                    SizedBox(height: 16),
                    CustomInputField(
                      label: S.current.service_description,
                      hintText: S.current.insert_service_description,
                      maxLines: 4,
                      onChanged: (value) {
                        context
                            .read<AddServiceBloc>()
                            .add(DescriptionChangedEvent(description: value));
                      },
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // context
                            //     .read<AddServiceBloc>()
                            //     .add(const ClickButtonCreateEvent(

                            //     ));
                          },
                          child: Text(S.current.save),
                          style: ElevatedButton.styleFrom(
                              // primary: Colors.lightBlue.shade100,
                              ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // context.read<AddServiceBloc>().add(ClickButtonCreateEvent());
                          },
                          child: Text(S.current.addservice),
                          style: ElevatedButton.styleFrom(
                              // primary: Colors.blue,
                              ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final int maxLines;
  final String? suffixText;
  final Function(String) onChanged;
  final TextInputType? type;
  const CustomInputField({
    Key? key,
    required this.label,
    required this.hintText,
    this.maxLines = 1,
    this.suffixText,
    this.type,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 8),
        TextField(
          keyboardType: type ?? TextInputType.text,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hintText,
            suffixText: suffixText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          onChanged: onChanged,
        ),
      ],
    );
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:file_picker/file_picker.dart';

// // Define Events
// abstract class ProductEvent extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class ProductNameChanged extends ProductEvent {
//   final String name;
//   ProductNameChanged(this.name);

//   @override
//   List<Object?> get props => [name];
// }

// class ProductDescriptionChanged extends ProductEvent {
//   final String description;
//   ProductDescriptionChanged(this.description);

//   @override
//   List<Object?> get props => [description];
// }

// class ProductPriceChanged extends ProductEvent {
//   final String price;
//   ProductPriceChanged(this.price);

//   @override
//   List<Object?> get props => [price];
// }

// class ProductTimeChanged extends ProductEvent {
//   final String time;
//   ProductTimeChanged(this.time);

//   @override
//   List<Object?> get props => [time];
// }

// class ProductEmployeeCountChanged extends ProductEvent {
//   final String count;
//   ProductEmployeeCountChanged(this.count);

//   @override
//   List<Object?> get props => [count];
// }

// class ProductImageChanged extends ProductEvent {
//   final PlatformFile file;
//   ProductImageChanged(this.file);

//   @override
//   List<Object?> get props => [file];
// }

// // Define State
// class ProductState extends Equatable {
//   final String name;
//   final String description;
//   final String price;
//   final String time;
//   final String employeeCount;
//   final PlatformFile? image;

//   const ProductState({
//     this.name = '',
//     this.description = '',
//     this.price = '',
//     this.time = '',
//     this.employeeCount = '',
//     this.image,
//   });

//   ProductState copyWith({
//     String? name,
//     String? description,
//     String? price,
//     String? time,
//     String? employeeCount,
//     PlatformFile? image,
//   }) {
//     return ProductState(
//       name: name ?? this.name,
//       description: description ?? this.description,
//       price: price ?? this.price,
//       time: time ?? this.time,
//       employeeCount: employeeCount ?? this.employeeCount,
//       image: image ?? this.image,
//     );
//   }

//   @override
//   List<Object?> get props => [name, description, price, time, employeeCount, image];
// }

// // Define Bloc
// class ProductBloc extends Bloc<ProductEvent, ProductState> {
//   ProductBloc() : super(ProductState());

//   @override
//   Stream<ProductState> mapEventToState(ProductEvent event) async* {
//     if (event is ProductNameChanged) {
//       yield state.copyWith(name: event.name);
//     } else if (event is ProductDescriptionChanged) {
//       yield state.copyWith(description: event.description);
//     } else if (event is ProductPriceChanged) {
//       yield state.copyWith(price: event.price);
//     } else if (event is ProductTimeChanged) {
//       yield state.copyWith(time: event.time);
//     } else if (event is ProductEmployeeCountChanged) {
//       yield state.copyWith(employeeCount: event.count);
//     } else if (event is ProductImageChanged) {
//       yield state.copyWith(image: event.file);
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:file_picker/file_picker.dart';
// import 'product_bloc.dart'; // Import the bloc file

// class AddProductPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (_) => ProductBloc(),
//       child: ProductForm(),
//     );
//   }
// }

// class ProductForm extends StatelessWidget {
//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Thêm sản phẩm'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               // Tên sản phẩm
//               BlocBuilder<ProductBloc, ProductState>(
//                 builder: (context, state) {
//                   return TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Tên sản phẩm',
//                       counterText: '${state.name.length}/120',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) =>
//                         context.read<ProductBloc>().add(ProductNameChanged(value)),
//                   );
//                 },
//               ),
//               SizedBox(height: 16),
              
//               // Mô tả sản phẩm
//               BlocBuilder<ProductBloc, ProductState>(
//                 builder: (context, state) {
//                   return TextFormField(
//                     maxLines: 3,
//                     decoration: InputDecoration(
//                       labelText: 'Mô tả sản phẩm',
//                       counterText: '${state.description.length}/3000',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) =>
//                         context.read<ProductBloc>().add(ProductDescriptionChanged(value)),
//                   );
//                 },
//               ),
//               SizedBox(height: 16),
              
//               // Dropdown danh mục
//               DropdownButtonFormField<String>(
//                 decoration: InputDecoration(
//                   labelText: 'Loại dịch vụ',
//                   border: OutlineInputBorder(),
//                 ),
//                 items: ['Loại 1', 'Loại 2', 'Loại 3']
//                     .map((String category) => DropdownMenuItem(
//                           value: category,
//                           child: Text(category),
//                         ))
//                     .toList(),
//                 onChanged: (value) {
//                   // Xử lý sự kiện chọn dropdown
//                 },
//               ),
//               SizedBox(height: 16),
              
//               // Giá sản phẩm
//               BlocBuilder<ProductBloc, ProductState>(
//                 builder: (context, state) {
//                   return TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Giá sản phẩm',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) =>
//                         context.read<ProductBloc>().add(ProductPriceChanged(value)),
//                   );
//                 },
//               ),
//               SizedBox(height: 16),

//               // Thời gian thực hiện
//               BlocBuilder<ProductBloc, ProductState>(
//                 builder: (context, state) {
//                   return TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Thời gian thực hiện',
//                       border: OutlineInputBorder(),
//                     ),
//                     onChanged: (value) =>
//                         context.read<ProductBloc>().add(ProductTimeChanged(value)),
//                   );
//                 },
//               ),
//               SizedBox(height: 16),

//               // Số lượng nhân viên
//               BlocBuilder<ProductBloc, ProductState>(
//                 builder: (context, state) {
//                   return TextFormField(
//                     decoration: InputDecoration(
//                       labelText: 'Số lượng nhân viên',
//                       border: OutlineInputBorder(),
//                     ),
//                     keyboardType: TextInputType.number,
//                     onChanged: (value) =>
//                         context.read<ProductBloc>().add(ProductEmployeeCountChanged(value)),
//                   );
//                 },
//               ),
//               SizedBox(height: 16),
              
//               // Nút chọn file ảnh
//               BlocBuilder<ProductBloc, ProductState>(
//                 builder: (context, state) {
//                   return Column(
//                     children: [
//                       ElevatedButton(
//                         onPressed: () async {
//                           FilePickerResult? result =
//                               await FilePicker.platform.pickFiles();
//                           if (result != null) {
//                             context
//                                 .read<ProductBloc>()
//                                 .add(ProductImageChanged(result.files.first));
//                           }
//                         },
//                         child: Text('Chọn ảnh'),
//                       ),
//                       if (state.image != null)
//                         Text('Đã chọn: ${state.image!.name}'),
//                     ],
//                   );
//                 },
//               ),
//               SizedBox(height: 16),
              
//               // Nút Submit
//               ElevatedButton(
//                 onPressed: () {
//                   if (_formKey.currentState!.validate()) {
//                     // Xử lý logic submit
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text('Đang gửi dữ liệu...')),
//                     );
//                   }
//                 },
//                 child: Text('Submit'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
