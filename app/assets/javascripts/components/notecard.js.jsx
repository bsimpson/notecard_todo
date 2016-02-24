var NotecardList = React.createClass({
  getInitialState: function() {
    return { data: [] };
  },
  loadNotecardsFromServer: function() {
    $.ajax({
      url: this.props.url,
      type: 'GET',
      dataType: 'json',
      success: function(data) {
        this.setState({ data: data })
      }.bind(this)
    });
  },
  componentDidMount: function() {
    this.loadNotecardsFromServer();
  },
  onNotecardSubmit: function(notecard) {
    $.ajax({
      url: '/notecards/' + notecard.id,
      dataType: 'json',
      type: 'PUT',
      data: { notecard: notecard },
      success: function(data) {
          this.setState({ data: data });
      }.bind(this),
      error: function(xhr, status, err) {
        console.log(status, err.toString());
      }.bind(this)
    })
  },
  render: function() {
    var notecard = this.state.data;
    var notecardNodes = 
      (
        <Notecard title={notecard.title}
                  body={notecard.body}
                  htmlified_body={notecard.htmlified_body}
                  id={notecard.id}
                  key={notecard.id}
                  onNotecardSubmit={this.onNotecardSubmit} />
      )

    return (
      <div className="notecardList">
        {notecardNodes}
      </div>
    )
  }
});

var Notecard = React.createClass({
  getInitialState: function() {
    return { edit: false };
  },
  handleEdit: function(evt) {
    evt.preventDefault();
    this.setState({ edit: true });
    this.render()
  },
  handleSubmit: function(evt) {
    evt.preventDefault();
    var body = this.state.body || this.props.body;
    var id = this.props.id;
    this.state.edit = false;
    this.props.onNotecardSubmit({ id: id, body: body });
  },
  handleBodyChange: function(evt) {
    this.setState({ body: evt.target.value });
  },
  render: function() {
    return (
      <div className="notecard-container">
        <div className="notecard row">
          <section className="title h1 col-sm-10">{this.props.title}</section>
        </div>
        <div className="row">
          {this.body()}
        </div>
      </div>
    )
  },
  htmlified_body: function() {
    return { __html: this.props.htmlified_body }
  },
  body: function() {
    if (this.state.edit) {
      return(
        <section className="body col-sm-12">
          <form>
            <div className="form-group">
              <textarea className="form-control" defaultValue={this.props.body} rows="5" onChange={this.handleBodyChange}></textarea>
            </div>
            <div className="row-fluid">
              <button type="button" className="btn btn-link col-sm-1">Cancel</button>
              <div className="col-sm-9"></div>
              <button type="button" className="btn btn-default col-sm-1">Preview</button>
              <button type="button" className="btn btn-primary col-sm-1" onClick={this.handleSubmit}>Save</button>
            </div>
          </form>
        </section>
      )
    } else {
      return (
        <section className="body col-sm-12">
          <div className="row-fluid" dangerouslySetInnerHTML={this.htmlified_body()}></div>
          <div clas="row">
            <div className="col-sm-11"></div>
            <input type="submit" className="btn btn-standard col-sm-1" onClick={this.handleEdit} value="Edit" />
          </div>
        </section>
      )
    }
  }
});

$(function() {
  ReactDOM.render(
    <NotecardList url="/notecards" />,
    document.getElementById('content')
  );
});
