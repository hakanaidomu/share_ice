import PropTypes from 'prop-types';
import React, { useState } from 'react';
import { HeartFill } from 'react-bootstrap-icons';

const Favorite = (props) => {
  const { favoriteId } = props;
  const [id, setId] = useState(favoriteId);

  const clicked = () => {
    console.log('clicked');
  }

  return (
    <>
      <HeartFill color={id ? 'red' : 'gray'} size={32} onClick={clicked}/>
    </>
  );
};

Favorite.propTypes = {};

export default props => <Favorite {...props} />;