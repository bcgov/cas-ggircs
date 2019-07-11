import React from 'react'
import {Accordion, Card, Button} from 'react-bootstrap'

const UserList = props => {
  return (
      <React.Fragment>
          <h3>Users</h3>
          <p>Data loaded from the GGIRCS portal schema</p>
          <br/>
          <Accordion defaultActiveKey="0">
              {props.users.edges.map( ({node}) => {
                  return (
                      <Card key={node.id}>
                          <Card.Header>
                              <Accordion.Toggle as={Button} variant="link" eventKey={node.id}>
                                  {node.firstName}
                              </Accordion.Toggle>
                          </Card.Header>
                          <Accordion.Collapse eventKey={node.id}>
                              <Card.Body>{node.lastName}</Card.Body>
                          </Accordion.Collapse>
                      </Card>
                  )
              })}
          </Accordion>
      </React.Fragment>
  )
}

export default UserList