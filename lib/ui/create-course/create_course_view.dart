import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'create_course_controller.dart';
import 'package:lms_admin/ui/all_instructor/all_instructor_controller.dart';

// ignore: must_be_immutable
class CreateCourseView extends StatelessWidget {
  final CreateCourseController _controller = Get.put(CreateCourseController());
  final InstructorController _instructorController =
      Get.put(InstructorController());
  //  List<Topic> topics = [];

  CreateCourseView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.1),
      appBar: AppBar(
        title: const Text('Create Course'),
      ),
      body: Obx(
        () => _controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Basic Information Section
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Basic Information',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                                onChanged: (value) =>
                                    _controller.title.value = value,
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                                onChanged: (value) =>
                                    _controller.description.value = value,
                                maxLines: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Pricing Section
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Pricing',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Text('Free '),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Obx(
                                    () => Switch(
                                      value: _controller.isFree.value,
                                      onChanged: (value) =>
                                          _controller.isFree.value = value,
                                      activeColor:
                                          Colors.green.withOpacity(0.3),
                                    ),
                                  ),
                                ],
                              ),
                              if (!_controller.isFree.value) ...[
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Flexible(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Price',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => _controller
                                            .price.value = double.parse(value),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Flexible(
                                      child: TextField(
                                        decoration: InputDecoration(
                                          labelText: 'Discount Percent',
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade400),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => _controller
                                            .discountPercent
                                            .value = int.parse(value),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                TextField(
                                  decoration: InputDecoration(
                                    labelText: 'Price with Discount',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade400),
                                    ),
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) => _controller
                                      .priceWithDiscount
                                      .value = double.parse(value),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Media Section
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Media',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Image URL',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                                onChanged: (value) =>
                                    _controller.image.value = value,
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Thumbnail URL',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                                onChanged: (value) =>
                                    _controller.thumbnail.value = value,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Type, Link, and Duration
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Flexible(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.green.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color:
                                                Colors.green.withOpacity(0.3)),
                                      ),
                                      child: DropdownButton<String>(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        isExpanded: true,
                                        value: _controller.type.value.isEmpty
                                            ? null
                                            : _controller.type.value,
                                        hint: const Text('Select Type'),
                                        items: const [
                                          DropdownMenuItem(
                                              value: 'video',
                                              child: Text('Video')),
                                          DropdownMenuItem(
                                              value: 'ebook',
                                              child: Text('Ebook')),
                                        ],
                                        onChanged: (value) => _controller
                                            .type.value = value ?? '',
                                        underline:
                                            SizedBox(), // Remove the default underline
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Flexible(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Duration (minutes)',
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade400),
                                        ),
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) => _controller
                                          .duration.value = int.parse(value),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              TextField(
                                decoration: InputDecoration(
                                  labelText: 'Link',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        BorderSide(color: Colors.grey.shade400),
                                  ),
                                ),
                                onChanged: (value) =>
                                    _controller.link.value = value,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      //add topic

                      ElevatedButton(
                        onPressed: () {
                          _controller.addTopic('New Topic');
                        },
                        child: Text('Add Topic'),
                      ),
                      Obx(() => Column(
                            children: List.generate(_controller.topics.length,
                                (topicIndex) {
                              return Card(
                                margin: EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        onChanged: (value) =>
                                            _controller.topics[topicIndex]
                                                ['title'] = value,
                                        decoration: InputDecoration(
                                            labelText: 'Topic Title'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          _controller.addLesson(
                                              topicIndex,
                                              'New Lesson',
                                              'lesson_url',
                                              'video',
                                              '10');
                                        },
                                        child: Text('Add Lesson'),
                                      ),
                                      Column(
                                        children: List.generate(
                                            _controller
                                                .topics[topicIndex]['lessons']
                                                .length, (lessonIndex) {
                                          return Card(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 4.0),
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  TextField(
                                                    onChanged: (value) =>
                                                        _controller.topics[
                                                                        topicIndex]
                                                                    ['lessons']
                                                                [lessonIndex]
                                                            ['title'] = value,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Lesson Title'),
                                                  ),
                                                  TextField(
                                                    onChanged: (value) =>
                                                        _controller.topics[
                                                                        topicIndex]
                                                                    ['lessons']
                                                                [lessonIndex][
                                                            'lessonUrl'] = value,
                                                    decoration: InputDecoration(
                                                        labelText:
                                                            'Lesson URL'),
                                                  ),
                                                 const SizedBox(height: 10,),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.green
                                                                .withOpacity(
                                                                    0.1),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            border: Border.all(
                                                                color: Colors
                                                                    .green
                                                                    .withOpacity(
                                                                        0.3)),
                                                          ),
                                                          child: DropdownButton<
                                                              String>(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        16.0),
                                                            isExpanded: true,
                                                            value: _controller
                                                                    .type
                                                                    .value
                                                                    .isEmpty
                                                                ? null
                                                                : _controller
                                                                    .type.value,
                                                            hint: const Text(
                                                                'Select Type'),
                                                            items: const [
                                                              DropdownMenuItem(
                                                                  value:
                                                                      'video',
                                                                  child: Text(
                                                                      'Video')),
                                                              DropdownMenuItem(
                                                                  value:
                                                                      'documnet',
                                                                  child: Text(
                                                                      'Document')),
                                                            ],
                                                            onChanged: (value) =>
                                                                _controller.topics[topicIndex]['lessons']
                                                                            [
                                                                            lessonIndex]
                                                                        [
                                                                        'type'] =
                                                                    value ?? '',

                                                            underline:
                                                                SizedBox(), // Remove the default underline
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Flexible(
                                                        child: TextField(
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  'Duration (minutes)',
                                                              border:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade400),
                                                              ),
                                                            ),
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            onChanged: (value) =>
                                                                _controller.topics[topicIndex]['lessons']
                                                                            [
                                                                            lessonIndex]
                                                                        [
                                                                        'duration'] =
                                                                    int.parse(
                                                                        value)),
                                                      ),
                                                    ],
                                                  ),

                                                  // TextField(
                                                  //   onChanged: (value) =>
                                                  //       _controller.topics[
                                                  //                       topicIndex]
                                                  //                   ['lessons']
                                                  //               [lessonIndex][
                                                  //           'duration'] = value,
                                                  //   decoration: InputDecoration(
                                                  //       labelText:
                                                  //           'Lesson Duration (mins)'),
                                                  //   keyboardType:
                                                  //       TextInputType.number,
                                                  // ),
                                                  // TextField(
                                                  //   onChanged: (value) =>

                                                  //   decoration: InputDecoration(
                                                  //       labelText:
                                                  //           'Lesson Type'),
                                                  // ),

                                                  IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      _controller.removeLesson(
                                                          topicIndex,
                                                          lessonIndex);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          if (_controller.topics.length > 1) {
                                            _controller.removeTopic(topicIndex);
                                          } else {
                                            Get.snackbar('Error',
                                                'At least one topic is required');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )),
                      SizedBox(height: 20),
                      // Category and Instructor Section
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Details',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                      color: Colors.green.withOpacity(0.3)),
                                ),
                                child: DropdownButton<String>(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  isExpanded: true,
                                  value: _controller.category.value.isEmpty
                                      ? null
                                      : _controller.category.value,
                                  hint: const Text('Select Category'),
                                  items: const [
                                    DropdownMenuItem(
                                        value: 'Programming',
                                        child: Text('Programming')),
                                    DropdownMenuItem(
                                        value: 'Design', child: Text('Design')),
                                  ],
                                  onChanged: (value) =>
                                      _controller.category.value = value ?? '',
                                  underline:
                                      SizedBox(), // Remove the default underline
                                ),
                              ),
                              const SizedBox(height: 8),
                              Obx(
                                () => Container(
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                        color: Colors.green.withOpacity(0.3)),
                                  ),
                                  child: DropdownButton<String>(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    isExpanded: true,
                                    value: _controller.teacher.value.isEmpty
                                        ? null
                                        : _controller.teacher.value,
                                    hint: const Text('Select Instructor'),
                                    items: _instructorController.instructors
                                        .map((instructor) {
                                      return DropdownMenuItem(
                                        value: instructor.id,
                                        child: Text(instructor.name ?? ''),
                                      );
                                    }).toList(),
                                    onChanged: (value) =>
                                        _controller.teacher.value = value ?? '',
                                    underline:
                                        SizedBox(), // Remove the default underline
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Subscription Included Switch
                      Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text('Subscription Included'),
                              SizedBox(
                                width: 10,
                              ),
                              Obx(
                                () => Switch(
                                  value: _controller.subscriptionIncluded.value,
                                  onChanged: (value) => _controller
                                      .subscriptionIncluded.value = value,
                                  activeColor: Colors.green.withOpacity(0.3),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Obx(() {
                          return _controller.isLoading.value
                              ? const CircularProgressIndicator()
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.green.withOpacity(0.3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 40, vertical: 15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: _controller.createCourse,
                                  child: const Text(
                                    'Create Course',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class Topic {
  String name;
  List<String> lessons;

  Topic({required this.name, required this.lessons});
}
