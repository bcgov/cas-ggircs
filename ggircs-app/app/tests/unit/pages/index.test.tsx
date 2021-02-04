import React from 'react';
import {shallow} from 'enzyme';
import Index from 'pages';

describe('landing', () => {
  it('matches the last accepted Snapshot', () => {
    const wrapper = shallow(
      <Index
        query={{
          session: null
        }}
      />
    );
    expect(wrapper).toMatchSnapshot();
  });
});
