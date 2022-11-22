import UIKit

final class NotesViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private var dataSource = [ShortNote(text: "Hello world")]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.register(NoteCell.self, forCellReuseIdentifier: NoteCell.reuseIdentifier)
        tableView.register(AddNoteCell.self, forCellReuseIdentifier: AddNoteCell.reuseIdentifier)
        tableView.backgroundColor = .clear
        tableView.keyboardDismissMode = .onDrag
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.pin(to: self.view)
    }
    
    private func setupNavigationBar() {
        self.title = "Notes"
    }
    
    private func handleDelete(indexPath: IndexPath) {
        dataSource.remove(at: indexPath.row)
        tableView.reloadData()
    }
}

extension NotesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let addNewCell = tableView.dequeueReusableCell(withIdentifier:
                AddNoteCell.reuseIdentifier, for: indexPath) as? AddNoteCell {
                addNewCell.delegate = self
                return addNewCell
            }
        }
        
        let note = dataSource[indexPath.row]
        if let noteCell = tableView.dequeueReusableCell(withIdentifier:
        NoteCell.reuseIdentifier, for: indexPath) as? NoteCell {
                        noteCell.configure(note)
                        return noteCell
        }
        
        return UITableViewCell()
    }
}

extension NotesViewController: UITableViewDelegate { }

extension NotesViewController: AddNoteDelegate {
    func newNoteAdded(note: ShortNote) {
        dataSource.insert(note, at: 0)
        tableView.reloadData()
    }
}
