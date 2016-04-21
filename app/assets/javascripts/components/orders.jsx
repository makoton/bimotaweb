// var React = require("react");

var Order = React.createClass({
    render: function () {
        return (
            <tr>
                <td>{this.props.uuid}</td>
                <td>{this.props.user_name}</td>
                <td><OrderStatus status={this.props.current_state}></OrderStatus></td>
                <td className="delete">
                    <div className="btn-group">
                        <a className="btn btn-default dropdown-toggle" data-toggle="dropdown" href="#"><i
                            className="fa fa-cog"></i>
                            <span className="caret"></span></a>
                        <ul className="dropdown-menu">
                            <li>
                                <a><i className="fa fa-eye"></i> Ver más</a>
                            </li>
                        </ul>
                    </div>
                </td>
            </tr>
        )
    }
})

var OrderStatus = React.createClass({
    render: function(){
        if(this.props.status == 'finished'){
            return <span className="label label-success">Finalizado</span>
        }else if(this.props.status == 'new'){
            return <span className="label label-primary">Nuevo</span>
        }else if(this.props.status == 'pending' || this.props.status == 'inprogress' ){
            return <span className="label label-warning">En Progreso</span>
        }else{
            return <span>Nuevo*</span>
        }
    }
})

var Orders = React.createClass({
    componentDidMount: function () {
        this.loadOrders().then(data => {
            this.setState({
                orders: data.orders
            })
        })
    },

    getInitialState: function () {
        return {
            orders: null
        }
    },

    render: function () {
        if (this.state.orders === null) {
            return (
                <div>
                    <i className="fa fa-spinner fa-pulse fa-fw margin-bottom"></i>
                    <span className="sr-only">Cargando...</span>
                </div>
            )
        } else {
            return (
                <table className="table table-striped">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Cliente</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    {this.state.orders.map(function (order) {
                        console.log(order);
                        return (
                            <Order key={order.uuid} uuid={order.uuid} user_name={order.user_name} current_state={order.current_state}></Order>
                        )
                    })}
                    </tbody>
                </table>
            )
        }
    },

    loadOrders: function () {
        return $.ajax({
            url: '/api/v1/orders',
            type: 'GET',
            contentType: 'application/json',
            dataType: 'json',
            processData: false
        })

    }
})