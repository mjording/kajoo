// Set a namespace for our code
window.iPhone = window.iPhone || {};

(function() {

	// Local shorthand variable
	var $i = this;

	// Shared variables
	$i.vars = {};

	// Shared utilities
	$i.utils = {

		// Adds class name to element
		addClass : function(element, elClass) {
			var curr = element.className;
			if (!new RegExp(("(^|\\s)" + elClass + "(\\s|$)"), "i").test(curr)) {
				element.className = curr + ((curr.length > 0) ? " " : "") + elClass;
			}
			return element;
		},

		// Removes class name from element
		removeClass : function(element, elClass) {
			if (elClass) {
				element.className = element.className.replace(elClass, "");
			} else {
				element.className = "";
				element.removeAttribute("class");
			}
			return element;
		},
		
		// Hide the annoying load bar
		hideURLBar : function() {
			setTimeout(function() {
				window.scrollTo(0, 1);
			}, 0);
		},
		
		// updateOrientation checks the current orientation, sets the body's class attribute to portrait,
		updateOrientation : function() {
			var orientation = window.orientation;
			
			switch (orientation) {
				
				// If we're horizontal
				case 90:
				case -90:
				
				// Set orient to landscape
				document.body.setAttribute("orient", "landscape");
				break;	
				
				// If we're vertical
				default:
				
				// Set orient to portrait
				document.body.setAttribute("orient", "portrait");
				break;
			}
			
		},
		
		getTranslateY : function(element) {
			var transform = element.style.webkitTransform;
			
			if (transform && transform !== "") {
				var translateY = parseFloat((/translateY\((\-?.*)px\)/).exec(transform)[1]);
			}
			
			return translateY;
		},
		
		setTranslateY : function(element, value) {
			element.style.webkitTransform = "translateY(" + value + "px)";
		},
		
		scrollToY : function(y) {
			var ms = 350; // number of milliseconds
			var content = document.querySelector("#content");
			
			// Grab current offset
			var top = $i.utils.getTranslateY(content);
			
			// Convert negative to positive if need be
			var currentTop = (top < 0) ? -(top) : top;
			
			// Divide offset by 250 (more offset = more scroll time)
			var chunks = (currentTop / 100);
			
			// Calculate total time
			var totalTime = (ms * chunks);
			
			// Make sure time does not exceed 750ms
			totalTime = (totalTime > 750) ? 750 : totalTime;
			
			// Prep for animation
			content.style.webkitTransition = "-webkit-transform " + totalTime + "ms cubic-bezier(0.1, 0.25, 0.1, 1.0)";
			
			// Animate to specified Y point
			$i.utils.setTranslateY(content, y);
			
			// Clean up after ourselves
			setTimeout(function() {
				content.style.webkitTransition = "none";
			}, totalTime);
		}
		
	};
	
	// Initialize
	$i.init = function() {
		
		// Sniff for orientation property
		if (typeof window.orientation !== "undefined") {
			
			// Fire events in onload namespace
			for (var key in $i.onload) {
				$i.onload[key]();
			}
			
			// Can't prevent user from tapping status bar
			// So instead, readjust fixed positions
			window.addEventListener("scroll", function() {
				$i.utils.addClass(document.body, "scrolled");
				
				// Scroll content to top as well
				$i.utils.scrollToY(11);
				
			}, false);
			
			// Remove scroll class on orientation change
			window.addEventListener("orientationchange", function() {
				$i.utils.removeClass(document.body, "scrolled");
			}, false);
			
			// Hide pesky URL bar
			$i.utils.hideURLBar();
			window.addEventListener("orientationchange", $i.utils.hideURLBar, false);
			
			// Point to the updateOrientation function when iPhone switches between portrait and landscape modes.
			$i.utils.updateOrientation();
			window.addEventListener("orientationchange", $i.utils.updateOrientation, false);
		}
	};
	
	$i.onload = {
		
		// Disable flick events
		disableScrollOnBody : function() {
			document.body.addEventListener("touchmove", function(e) {
				e.preventDefault();
			}, false);
		},
		
		// Create an area to tap to return to top
		// (can't use status bar for obvious reasons)
		scrollToTop : function() {
			// Header
			var header = document.querySelector("#header");
			if (header) {
				
				// Cancel event if user drags finger off
				header.addEventListener("touchmove", function() {
					this.cancel = true;
				}, false);
				
				// Scroll to top (if not canceled)
				header.addEventListener("touchend", function() {
					if (!this.cancel) {
						$i.utils.scrollToY(0);
					}
					
					// Reset flag
					this.cancel = false;
				}, false);
			}
		},
		
		// Enable area for scrolling
		enableScrollOnContent : function() {
			
			// Grab elements
			var content = document.querySelector("#content");
			var container = document.querySelector("#container");
			
			if (content) {
				
				// Set shared variables
				var startY, startTime, endY, endTime;
				
				// Log starting Y-point and time stamp
				content.addEventListener("touchstart", function(e) {
					startY = e.touches[0].clientY;
					startTime = e.timeStamp;
				}, false);
				
				// Scroll on finger drag
				content.addEventListener("touchmove", function(e) {
					
					// Current Y-point
					var posY = e.touches[0].pageY;
					
					// Set previous position
					$i.vars.oldY = $i.vars.oldY || posY;
					
					// Set a top value (if none exists)
					if (!this.style.webkitTransform) {
						$i.utils.setTranslateY(this, 0);
					}
					
					// Make sure we don't scroll past boundaries
					var value;
					var boundary = (container.offsetHeight - this.offsetHeight);
					
					// If current position is greater than old position
					if (posY > $i.vars.oldY) {
						
						// Value = current position + (Y-point - old position)
						value = $i.utils.getTranslateY(this) + (posY - $i.vars.oldY);
						
						// If value is negative
						if (value <= 0) {
							
							// We're good
							$i.utils.setTranslateY(this, value);
							
						// Otherwise, we're over the limit
						} else {
							
							// So mimic the 'snap' to top
							$i.utils.setTranslateY(this, (value * 0.9));
						}
					
					// If current position is less than old position
					} else if (posY < $i.vars.oldY) {
						
						// Value = current position - (old position - Y-point)
						value = $i.utils.getTranslateY(this) - ($i.vars.oldY - posY);
						
						// If value is greater than or equal to boundary
						if (value >= boundary) {
							
							// We're good
							$i.utils.setTranslateY(this, value);
						}
					}
					
					// Done with function, current position is now old
					$i.vars.oldY = posY;
					
					// Prevent default action
					e.preventDefault();
				}, false);
				
				// Ease movement when finger is removed
				content.addEventListener("touchend", function(e) {
					
					// Log current Y-point
					endY = e.changedTouches[0].clientY;
					
					// Log timestamp
					endTime = e.timeStamp;
					
					// Log current Y offset
					var posY = $i.utils.getTranslateY(this);
					
					// If offset is greater than 0
					if (posY > 0) {
						
						// Scroll to 0
						$i.utils.scrollToY(0);
					} else {
						
						// Do all the math
						var distance = startY - endY;
						var time = endTime - startTime;
						var speed = Math.abs(distance / time);
						
						// y = current position - (distance * speed)
						var y = $i.utils.getTranslateY(this) - (distance * speed);
						
						if ((time < 600) && distance > 50) {
							// Flicks should go farther
							y = y + (y * 0.2);
						}

						
						// Set boundary
						var boundary = (container.offsetHeight - this.offsetHeight);
						
						// Make sure y does not exceed boundaries
						y = (y <= boundary) ? boundary : (y > 0) ? 0 : y;

						// Scroll to specified point
						$i.utils.scrollToY(y);
					}
					
					// Clean up after ourselves
					delete $i.vars.oldY;
				}, false);

			}
		},
		
		// Mimic native footer UI
		nativeFooter : function() {
			
			// Target element
			var footer = document.querySelector("#footer");
			if (footer) {
				
				// Grab all 'tabs'
				var tabs = footer.getElementsByTagName("li");
				for (var i = 0, j = tabs.length; i < j; i++) {
					var tab = tabs[i];
					
					// Add active class on touch
					tab.addEventListener("touchstart", function() {
						
						// Remove classes from other active nodes
						for (var k = 0, l = tabs.length; k < l; k++) {
							$i.utils.removeClass(tabs[k], "active");
						}
						
						// Add active to self
						$i.utils.addClass(this, "active");
					}, false);
				}
			}
		},
		
		// Links need special treatment so as not to interfere with scroll
		enableLinksOnTap : function() {
			
			// Target nodes
			var items = document.querySelectorAll("#content ul li");
			for (var i = 0, j = items.length; i < j; i++) {
				var item = items[i];
				
				// On touch
				item.addEventListener("touchstart", function(e) {
					var _this = this;
					
					// Add active class after a short timeout
					// (timeout removes interference with scroll)
					this.timeout = setTimeout(function() {
						$i.utils.addClass(_this, "active");
					}, 150);
					
					// Prevent default
					e.preventDefault();
				}, false);
				
				// On finger scroll
				item.addEventListener("touchmove", function(e) {
					
					// Clear timeout
					clearTimeout(this.timeout);
					
					// Remove active class
					$i.utils.removeClass(this, "active");
					
					// User has canceled event
					this.cancel = true;
				}, false);
				
				// On finger up
				item.addEventListener("touchend", function(e) {
					
					// If event has not been canceled
					if (!this.cancel) {
						
						// Remove active class
						$i.utils.removeClass(this, "active");
						
						// Go to URL
						location.href = this.getElementsByTagName("span")[0].getAttribute("rel");
					}
					
					// Reset flag
					this.cancel = false;
				}, false);
			}
		}
	};
	
	// Fire on load
	window.addEventListener("load", $i.init, false);
	
}).call(window.iPhone); // Initialize