/* EDIT CONTROLLER: this controller uses 'this', and the controlValue seems to not update (a bug for you to fix! possibly one new line of code ~ 14 characters, and one modification of something that already exists)*/
    app.controller('editController', ['$scope', 'userFactory', '$location', '$routeParams', function($scope, userFactory, $location, rParams) {
      /* Public Properties */
      var self = this;
      this.controlValue = "Current Name:";

      /* Public Methods */
      this.getUser = function() {
        userFactory.show(rParams.id, function passedToUserFactoryShow(user) {
          $scope.user = user;
          //console.log(user) // one user

        })
      }

      this.updateUser = function(){
        userFactory.update($scope.users, rParams.id, function passedToUserFactoryUpdate(userFromFactory){
          $scope.user = userFromFactory;
          // what is this?

          self.controlValue = "Updated Name: "

          // $location.url('/edit/rParams.id')
        });
      }
      /* on load time */
      this.getUser();
      console.log(this);
    }]);