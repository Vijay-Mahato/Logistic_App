class DrivingMethodModel {
  int? id;
  String? brand;
  String? capacity;
  String? color;
  String? drivingMethod;
  String? fuelType;
  String? licensePlateNumber;
  String? mileAge;
  String? modelName;
  String? status;
  String? type;
  int? userId;
  String? year;
  List<String>? vehicleImages=[];

  DrivingMethodModel(
      {this.id,
        this.brand,
        this.capacity,
        this.color,
        this.drivingMethod,
        this.fuelType,
        this.licensePlateNumber,
        this.mileAge,
        this.modelName,
        this.status,
        this.type,
        this.userId,
        this.year,
        this.vehicleImages});

  DrivingMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    brand = json['brand']??'';
    capacity = json['capacity']??'';
    color = json['color']??'';
    drivingMethod = json['drivingMethod']??'';
    fuelType = json['fuelType']??'';
    licensePlateNumber = json['licensePlateNumber']??'';
    mileAge = json['mileAge']??'';
    modelName = json['modelName']??'';
    status = json['status']??'';
    type = json['type']??'';
    userId = json['userId'];
    year = json['year']??'';
    vehicleImages = json['vehicleImages'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['brand'] = this.brand;
    data['capacity'] = this.capacity;
    data['color'] = this.color;
    data['drivingMethod'] = this.drivingMethod;
    data['fuelType'] = this.fuelType;
    data['licensePlateNumber'] = this.licensePlateNumber;
    data['mileAge'] = this.mileAge;
    data['modelName'] = this.modelName;
    data['status'] = this.status;
    data['type'] = this.type;
    data['userId'] = this.userId;
    data['year'] = this.year;
    data['vehicleImages'] = this.vehicleImages;
    return data;
  }
}