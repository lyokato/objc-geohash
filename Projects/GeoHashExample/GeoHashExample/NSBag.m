#import "NSBag.h"


@implementation NSBag
- (id) init
{
	if (!(self = [super init])) return self;
	dict = [[NSMutableDictionary alloc] init] ;
	return self;
}

+ (NSBag *) bag
{
	return [[NSBag alloc] init] ;
}

- (void) add: (id) anObject
{
	int count = 0;
	NSNumber *num = [dict objectForKey:anObject];
	if (num) count = [num intValue];
	NSNumber *newnum = [NSNumber numberWithInt:count + 1];
	[dict setObject:newnum forKey:anObject];	
}

+ (NSBag *) bagWithObjects:(id)item,...
{
	NSBag *bag = [NSBag bag];
	if (!item) return bag;
	[bag add:item];
	
	va_list objects;
	va_start(objects, item);
	id obj = va_arg(objects, id);
	while (obj)
	{
		[bag add:obj];
		obj = va_arg(objects, id);
	}
	va_end(objects);
	return bag;
}

- (void) addObjects:(id)item,...
{
	if (!item) return;
	[self add:item];

	va_list objects;
	va_start(objects, item);
	id obj = va_arg(objects, id);
	while (obj)
	{
		[self add:obj];
		obj = va_arg(objects, id);
	}
	va_end(objects);
}

- (void) remove: (id) anObject
{
	NSNumber *num = [dict objectForKey:anObject];
	if (!num) return;
	if ([num intValue] == 1) 
	{
		[dict removeObjectForKey:anObject];
		return;
	}
	NSNumber *newnum = [NSNumber numberWithInt:([num intValue] - 1)];
	[dict setObject:newnum forKey:anObject];	
}

- (NSInteger) occurrencesOf: (id) anObject
{
	NSNumber *num = [dict objectForKey:anObject];
	return [num intValue];
}

- (NSArray *) objects
{
	return [dict allKeys];
}

- (NSString *) description
{
	return [dict description];
}

- (NSDictionary *) internalDictionary{
    return dict;
}


@end
