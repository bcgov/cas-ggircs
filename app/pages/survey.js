import React , { Component } from 'react'
import Header from '../components/Header';
import FormLoader from '../components/Forms/FormLoader';


class BaseForm extends Component {

    render() {
        return (
            <React.Fragment>
                <Header/>
                <FormLoader/>
            </React.Fragment>
            );
    }
}

export default BaseForm;

/*
1: create a table called forms - done
2: add two forms to the table - done
2.1 - why isn't graphile creating a formById? - done, needs unique index
3: fetch forms using graphql
4: create a component that takes form id and loads form json
5: pass component to baseform
6: create table to store results of form (user id, form id, key, value)
7: create a mutation (postgraphile should do this?) to store json results
8: call mutation on save form
 */