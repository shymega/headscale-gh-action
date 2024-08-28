const core = require('@actions/core');

/**
 * The main function for the action.
 * @returns {Promise<void>} Resolves when the action is complete.
 */
module.exports = async function run () {
  try {
    // Log the current timestamp, wait, then log the new timestamp
    core.debug(new Date().toTimeString());
    core.setOutput('success', true);
  } catch (error) {
    // Fail the workflow run if an error occurs
    core.setFailed(error.message);
  }
};
