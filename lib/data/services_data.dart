// Represents one medical service shown in the service catalog.
class MedicalService {
  final String name;
  final String imageUrl;
  final String price;
  final String age;
  final String gender;
  final String included;

  const MedicalService({
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.age,
    required this.gender,
    required this.included,
  });
}

// Local service data kept separate so it can be replaced by an API response.
class ServicesData {
  static const filters = ['Most Book', 'Top Rated', 'Man', 'Woman'];

  static const services = [
    MedicalService(
      name: 'General medicine',
      imageUrl:
          'https://images.unsplash.com/photo-1584982751601-97dcc096659c?w=200',
      price: '100\$',
      age: '>18 years old',
      gender: 'Man, Woman',
      included: '10 tests',
    ),
    MedicalService(
      name: 'Blood Test',
      imageUrl:
          'https://images.unsplash.com/photo-1579154204601-01588f351e67?w=200',
      price: '5\$',
      age: '>18 years old',
      gender: 'Man, Woman',
      included: '10 tests',
    ),
    MedicalService(
      name: 'Ultrasound (Uterus, Fallopian\nTubes, Pregnancy)',
      imageUrl:
          'https://images.unsplash.com/photo-1559757175-0eb30cd8c063?w=200',
      price: '20\$',
      age: '>18 years old',
      gender: 'Man, Woman',
      included: '10 tests',
    ),
    MedicalService(
      name: 'Cervical cancer vaccination',
      imageUrl:
          'https://images.unsplash.com/photo-1618498082410-b4aa22193b38?w=200',
      price: '230\$',
      age: '>18 years old',
      gender: 'Woman',
      included: '9 tests',
    ),
    MedicalService(
      name: 'General medicine',
      imageUrl: '',
      price: '100\$',
      age: '>18 years old',
      gender: 'Man, Woman',
      included: '10 tests',
    ),
  ];
}
