import React, { Component } from 'react'
import { graphql } from 'react-relay'
import withData from '../lib/withData'
import Header from '../components/Header'
import Footer from '../components/Footer'
import SignIn from '../components/SignIn'
import { Container, Row, Col } from 'react-bootstrap';
import UserList from "../components/UserList";

class Index extends Component {
  static displayName = `Index`

  static async getInitialProps (context) {
    let { after, before, first, last } = context.query

    if (last === undefined) {
      first = 2
    }

    return {
      relayVariables: {
        after,
        before,
        first: parseInt(first, 10),
        last: parseInt(last, 10)
      }
    }
  }


  render (props) {
    return (
      <React.Fragment>
        <Header/>
        <Container>
          <Row>
            <Col md={6}>
              <UserList users={this.props.allUsers}/>
            </Col>
            <Col md={6}>
              <SignIn/>
            </Col>
          </Row>
        </Container>

      </React.Fragment>
    )
  }
}

export default withData(Index, {
  query: graphql`
    query pages_indexQuery {
      allUsers{
        pageInfo{
          hasNextPage
          hasPreviousPage
          startCursor
          endCursor
        }
        edges{
          node{
            id
            firstName
            lastName
          }
        }
      }
    }
  `
})
