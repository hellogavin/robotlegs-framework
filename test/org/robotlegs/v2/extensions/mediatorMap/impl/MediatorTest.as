//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved. 
// 
//  NOTICE: You are permitted to use, modify, and distribute this file 
//  in accordance with the terms of the license agreement accompanying it. 
//------------------------------------------------------------------------------

package org.robotlegs.v2.extensions.mediatorMap.impl
{
	import flash.display.Sprite;
	import org.flexunit.asserts.*;
	import org.robotlegs.v2.extensions.mediatorMap.api.IMediator;
	import org.robotlegs.v2.extensions.mediatorMap.impl.support.MediatorWatcher;
	import org.robotlegs.v2.extensions.mediatorMap.impl.support.TrackingMediator;
	import org.robotlegs.v2.extensions.mediatorMap.impl.support.TrackingMediatorWaitsForGiven;
	import flash.events.Event;
	import org.robotlegs.base.EventMap;
	import flash.events.EventDispatcher;

	public class MediatorTest
	{

		private var instance:Mediator;

		private var mediatorWatcher:MediatorWatcher;

		private var trackingMediator:TrackingMediator;

		[Before]
		public function setUp():void
		{
			instance = new Mediator();
			mediatorWatcher = new MediatorWatcher();
			trackingMediator = new TrackingMediator(mediatorWatcher);
		}

		[After]
		public function tearDown():void
		{
			instance = null;
			mediatorWatcher = null;
			trackingMediator = null;
		}

		[Test]
		public function can_be_instantiated():void
		{
			assertTrue("instance is Mediator", instance is Mediator);
		}

		[Test]
		public function getViewComponent_matches_setViewComponent():void
		{
			const view:Sprite = new Sprite();
			instance.setViewComponent(view);
			assertEquals(view, instance.getViewComponent());
		}

		[Test]
		public function implements_IMediator():void
		{
			assertTrue(instance is IMediator)
		}

		[Test]
		public function initialize_runs_onRegister_immediately():void
		{
			trackingMediator.setViewComponent(new Sprite());
			trackingMediator.initialize();
			var expectedNotifications:Vector.<String> = new <String>[TrackingMediator.ON_REGISTER];
			assertEqualsVectorsIgnoringOrder(expectedNotifications, mediatorWatcher.notifications);
		}

		[Test]
		public function destroy_runs_onRemove_immediately():void
		{
			trackingMediator.setViewComponent(new Sprite());
			trackingMediator.destroy();
			var expectedNotifications:Vector.<String> = new <String>[TrackingMediator.ON_REMOVE];
			assertEqualsVectorsIgnoringOrder(expectedNotifications, mediatorWatcher.notifications);
		}
		
		[Test]
		public function destroyed_defaults_to_false():void
		{
			assertFalse(instance.destroyed);
		}
		
		[Test]
		public function get_set_destroyed_to_true():void 
		{
			instance.destroyed =  true;
			assertTrue(instance.destroyed);
		}

		[Test]
		public function get_set_destroyed_to_false():void 
		{
			instance.destroyed = true;
			instance.destroyed =  false;
			assertFalse(instance.destroyed);
		}
		
		[Test]
		public function test_failure_seen():void
		{
			assertTrue("Failing test", true);
		}
		// mediator pauses event map on view removed and resumes again on view added
		// sugar methods for add / remove view listener and context listener
		// don't run the onRegister if 'removed'
	}
}