// GENERATED CODE - DO NOT MODIFY BY HAND

part of example.one_to_many;

// **************************************************************************
// BeanGenerator
// **************************************************************************

abstract class _AuthorBean implements Bean<Author> {
  String get tableName => Author.tableName;

  final StrField id = new StrField('id');

  final StrField name = new StrField('name');

  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        name.name: name,
      };
  Author fromMap(Map map) {
    Author model = new Author();

    model.id = adapter.parseValue(map['id']);
    model.name = adapter.parseValue(map['name']);

    return model;
  }

  List<SetColumn> toSetColumns(Author model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(name.set(model.name));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(name.name)) ret.add(name.set(model.name));
    }

    return ret;
  }

  Future createTable() async {
    final st = Sql.create(tableName);
    st.addStr(id.name, primary: true);
    st.addStr(name.name);
    return execCreateTable(st);
  }

  Future<dynamic> insert(Author model, {bool cascade: false}) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    var retId = await execInsert(insert);
    if (cascade) {
      Author newModel;
      if (model.posts != null) {
        newModel ??= await find(model.id);
        model.posts.forEach((x) => postBean.associateAuthor(x, newModel));
        for (final child in model.posts) {
          await postBean.insert(child);
        }
      }
    }
    return retId;
  }

  Future<int> update(Author model,
      {bool cascade: false, bool associate: false, Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    final ret = execUpdate(update);
    if (cascade) {
      Author newModel;
      if (model.posts != null) {
        if (associate) {
          newModel ??= await find(model.id);
          model.posts.forEach((x) => postBean.associateAuthor(x, newModel));
        }
        for (final child in model.posts) {
          await postBean.update(child);
        }
      }
    }
    return ret;
  }

  Future<Author> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    final Author model = await execFindOne(find);
    if (preload) {
      await this.preload(model, cascade: cascade);
    }
    return model;
  }

  Future<int> remove(String id, [bool cascade = false]) async {
    if (cascade) {
      final Author newModel = await find(id);
      await postBean.removeByAuthor(newModel.id);
    }
    final Remove remove = remover.where(this.id.eq(id));
    return execRemove(remove);
  }

  Future<int> removeMany(List<Author> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return execRemove(remove);
  }

  Future preload(Author model, {bool cascade: false}) async {
    model.posts = await postBean.findByAuthor(model.id,
        preload: cascade, cascade: cascade);
  }

  Future preloadAll(List<Author> models, {bool cascade: false}) async {
    models.forEach((Author model) => model.posts ??= []);
    await PreloadHelper.preload<Author, Post>(
        models,
        (Author model) => [model.id],
        postBean.findByAuthorList,
        (Post model) => [model.authorId],
        (Author model, Post child) => model.posts.add(child),
        cascade: cascade);
  }

  PostBean get postBean;
}

abstract class _PostBean implements Bean<Post> {
  String get tableName => Post.tableName;

  final StrField id = new StrField('id');

  final StrField message = new StrField('message');

  final StrField authorId = new StrField('author_id');

  Map<String, Field> _fields;
  Map<String, Field> get fields => _fields ??= {
        id.name: id,
        message.name: message,
        authorId.name: authorId,
      };
  Post fromMap(Map map) {
    Post model = new Post();

    model.id = adapter.parseValue(map['id']);
    model.message = adapter.parseValue(map['message']);
    model.authorId = adapter.parseValue(map['author_id']);

    return model;
  }

  List<SetColumn> toSetColumns(Post model,
      {bool update = false, Set<String> only}) {
    List<SetColumn> ret = [];

    if (only == null) {
      ret.add(id.set(model.id));
      ret.add(message.set(model.message));
      ret.add(authorId.set(model.authorId));
    } else {
      if (only.contains(id.name)) ret.add(id.set(model.id));
      if (only.contains(message.name)) ret.add(message.set(model.message));
      if (only.contains(authorId.name)) ret.add(authorId.set(model.authorId));
    }

    return ret;
  }

  Future createTable() async {
    final st = Sql.create(tableName);
    st.addStr(id.name, primary: true);
    st.addStr(message.name);
    st.addStr(authorId.name, foreignTable: Author.tableName, foreignCol: 'id');
    return execCreateTable(st);
  }

  Future<dynamic> insert(Post model) async {
    final Insert insert = inserter.setMany(toSetColumns(model));
    return execInsert(insert);
  }

  Future<int> update(Post model, {Set<String> only}) async {
    final Update update = updater
        .where(this.id.eq(model.id))
        .setMany(toSetColumns(model, only: only));
    return execUpdate(update);
  }

  Future<Post> find(String id,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.id.eq(id));
    return await execFindOne(find);
  }

  Future<int> remove(String id) async {
    final Remove remove = remover.where(this.id.eq(id));
    return execRemove(remove);
  }

  Future<int> removeMany(List<Post> models) async {
    final Remove remove = remover;
    for (final model in models) {
      remove.or(this.id.eq(model.id));
    }
    return execRemove(remove);
  }

  Future<List<Post>> findByAuthor(String authorId,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder.where(this.authorId.eq(authorId));
    return await (await execFind(find)).toList();
  }

  Future<int> removeByAuthor(String authorId) async {
    final Remove rm = remover.where(this.authorId.eq(authorId));
    return await execRemove(rm);
  }

  Future<List<Post>> findByAuthorList(List<Author> models,
      {bool preload: false, bool cascade: false}) async {
    final Find find = finder;
    for (Author model in models) {
      find.or(this.authorId.eq(model.id));
    }
    return await (await execFind(find)).toList();
  }

  void associateAuthor(Post child, Author parent) {
    child.authorId = parent.id;
  }
}
