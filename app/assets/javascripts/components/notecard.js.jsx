var NotecardList = React.createClass({
  getInitialState: function() {
    return { data: [] };
  },
  loadNotecardsFromServer: function() {
    $.ajax({
      url: this.props.url,
      type: 'GET',
      dataType: 'json',
      success: function(data) { this.setState({ data: data }) }.bind(this)
    });
  },
  componentDidMount: function() {
    this.loadNotecardsFromServer();
  },
  render: function() {
    var notecardNodes = this.state.data.map(function(notecard) {
      return (
        <Notecard title={notecard.title} body={notecard.body} key={notecard.id} />
      )
    });

    return (
      <div className="notecardList">
        {notecardNodes}
      </div>
    )
  }
});

var Notecard = React.createClass({
  render: function() {
    return (
      <div className="notecard">
        <section className="title">{this.props.title}</section>
        <section className="body">{this.props.body}</section>
      </div>
    )
  }
});

$(function() {
  ReactDOM.render(
    <NotecardList url="/notecard" />,
    document.getElementById('content')
  );
});
