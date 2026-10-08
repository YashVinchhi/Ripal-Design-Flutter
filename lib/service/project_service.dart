class ProjectDraft {
  String projectName = '';
  String sector = 'Residential Luxe';
  String timeline = '';
  String description = '';
  String budget = '';
  String ownerName = '';
  String ownerEmail = '';
  String ownerPhone = '';
  List<Map<String, String>> teamMembers = [
    {
      'initials': 'DD',
      'name': 'Deep Dudhaiya',
      'role': 'worker',
      'email': 'apixgamer40@gmail.com',
    },
    {
      'initials': 'RS',
      'name': 'Rajibul Sheikh',
      'role': 'worker',
      'email': 'rajibulsheikh098@gmail.com',
    },
  ];
  List<Map<String, dynamic>> uploadedFiles = [
    {
      'filename': 'Modernist_Villa_Phase_01.dwg',
      'progress': 1.0,
      'progressText': '100%',
    },
    {
      'filename': 'Material_Swatches_HD.zip',
      'progress': 1.0,
      'progressText': '100%',
    },
  ];
  int maxStepReached = 1;

  void reset() {
    projectName = '';
    sector = 'Residential Luxe';
    timeline = '';
    description = '';
    budget = '';
    ownerName = '';
    ownerEmail = '';
    ownerPhone = '';
    maxStepReached = 1;
  }
}

class ProjectService {
  static final ProjectDraft draft = ProjectDraft();
  static void resetDraft() => draft.reset();

  static bool validateStep1(ProjectDraft draft, {required Function(String) onError}) {
    if (draft.projectName.trim().isEmpty) {
      onError('Please enter a project name');
      return false;
    }
    if (draft.timeline.trim().isEmpty) {
      onError('Please enter an estimated timeline');
      return false;
    }
    if (draft.description.trim().length < 10) {
      onError('Project description must be at least 10 characters');
      return false;
    }
    if (draft.budget.trim().isEmpty) {
      onError('Please enter a target budget');
      return false;
    }
    if (draft.ownerName.trim().isEmpty) {
      onError('Please enter the owner / client name');
      return false;
    }
    if (draft.ownerEmail.trim().isEmpty || !draft.ownerEmail.contains('@')) {
      onError('Please enter a valid owner email address');
      return false;
    }
    final cleanPhone = draft.ownerPhone.replaceAll(RegExp(r'\D'), '');
    if (cleanPhone.length != 10) {
      onError('Owner phone number must be exactly 10 digits');
      return false;
    }
    return true;
  }

  static bool validateStep2(ProjectDraft draft, {required Function(String) onError}) {
    if (draft.teamMembers.isEmpty) {
      onError('Please assign or add at least one team member');
      return false;
    }
    return true;
  }

  static bool validateStep3(ProjectDraft draft, {required Function(String) onError}) {
    if (draft.uploadedFiles.isEmpty) {
      onError('Please select at least one project file');
      return false;
    }
    return true;
  }
}
