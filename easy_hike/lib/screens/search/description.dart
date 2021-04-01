import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DescriptionExample extends StatefulWidget {
  @override
  _DescriptionExampleState createState() => _DescriptionExampleState();
}

class _DescriptionExampleState extends State<DescriptionExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Material(
        elevation: 15.0,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.1,
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                height: MediaQuery.of(context).size.height * 0.06,
                color: const Color(0xFFEA6161),
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                minWidth: MediaQuery.of(context).size.width * 0.7,
                elevation: 0,
                hoverElevation: 0,
                highlightElevation: 0,
                child: const Text(
                  'Apply Now',
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.06,
                width: MediaQuery.of(context).size.width * 0.13,
                decoration: BoxDecoration(
                    color: const Color(0xFFE5E9EE),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(color: Colors.grey[300])),
                child: IconButton(
                  color: const Color(0xFFEA6161),
                  onPressed: () {},
                  icon: const Icon(Icons.favorite_border),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(15.0),
        children: [
          Center(
            child: Column(
              children: [
                const FaIcon(
                  FontAwesomeIcons.google,
                  size: 35.0,
                ),
                const SizedBox(
                  height: 20.0,
                ),
                const Text(
                  'Product Designer',
                  style: TextStyle(
                    fontSize: 30.0,
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Text(
                  'Cairo, Egypt',
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        color: Color(0xFFE5E9EE),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Full Time',
                      ),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      '₹4500/mo',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Divider(
                    color: Colors.grey[400],
                    thickness: 1.0,
                  ),
                ),
              ],
            ),
          ),
          Description(
            description:
                "A product designer is responsible for the design and development of consumer products. Duties of this position include improving existing product designs and analyzing working concepts launched by competitors of similar products to match quality and performance. Depending on the industry and company, product designers may progress to a senior, executive or managerial role.",
          ),
          SizedBox(
            height: 20.0,
          ),
          Responsibilities(
            responsibilities: [
              'Create design concepts and drawings to determine the best product',
              'Present product ideas to relevant team members for brainstorming',
              'Suggest improvements to design and performance to product engineers',
              'Employ design concepts into functional prototypes',
              'Perform research on product technologies and structures to implement into design concepts',
              'Maintain up to date on current industry trends and market conditions',
              'Coordinate with designers to ensure accurate communication and efficiency in the design phase',
              'Modify and revise existing designs to meet customer expectations',
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Qualifications(
            qualifications: [
              'Relevant work experience as a product designer is preferred',
              'Exceptional verbal and written communication skills',
              'Excellent eye for aesthetic design and customer appeal',
              'Good understanding of color science and combinations',
              'Artistic and innovative flair',
              'Excellent attention to detail',
              'Meticulous and diligent',
              'Strong knowledge of the industry and market trends',
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Other Job Details',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20.0,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Remote Work Level'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('100% Remote'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Date Posted'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('03/03/2021'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Job Type'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Freelance'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Job Schedule'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Part-Time'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Career Level'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Experienced'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Travel Required'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('No specification'),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Categories'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Designer'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Description extends StatelessWidget {
  final String description;
  const Description({
    @required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Text("$description"),
        ],
      ),
    );
  }
}

class Responsibilities extends StatelessWidget {
  final List<String> responsibilities;
  const Responsibilities({
    @required this.responsibilities,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Responsibilities',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in responsibilities)
                Text('${String.fromCharCode(0x2022)} $item\n'),
            ],
          ),
        ],
      ),
    );
  }
}

class Qualifications extends StatelessWidget {
  final List<String> qualifications;
  const Qualifications({
    @required this.qualifications,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Qualifications',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var item in qualifications)
                Text('${String.fromCharCode(0x2022)} $item\n'),
            ],
          ),
        ],
      ),
    );
  }
}
