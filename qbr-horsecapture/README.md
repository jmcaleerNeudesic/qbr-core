# QBR Horse Capture & Trading System

A comprehensive horse capture and selling system for QBR-Core (RedM).

## Features

- **Capture Wild Horses** - Tame wild horses found in the world
- **Sell for Profit** - Sell captured horses at dealers for cash
- **Multiple Locations** - 4 horse dealer locations across the map
- **Realistic Mechanics** - Taming takes time with chance of failure
- **Economy Integration** - Fully integrated with QBR-Core money system

## Installation

1. Copy the `qbr-horsecapture` folder to your resources directory
2. Add `ensure qbr-horsecapture` to your server.cfg
3. Restart your server

## How to Use

### Capturing Horses

1. Find a wild horse in the world (Mustangs, Nokotas, Tennessee Walkers, etc.)
2. Approach the horse (within 10 meters)
3. Hold the prompted button to tame the horse
4. Wait for the taming process to complete (10 seconds)
5. 80% chance of success - if successful, the horse is yours!

### Selling Horses

1. Ride your captured wild horse to any horse dealer location:
   - Valentine Horse Dealer
   - Blackwater Horse Dealer
   - Rhodes Horse Dealer
   - Saint Denis Horse Dealer
2. Hold the prompted button while on the horse
3. Receive cash equal to 50% of the horse's base value

## Configuration

Edit `config.lua` to customize:

- **Detection Radius** - How close you need to be to tame (default: 10 meters)
- **Taming Time** - How long taming takes (default: 10 seconds)
- **Sell Percentage** - Percentage of base price when selling (default: 50%)
- **Wild Horse Models** - Which horse models can be captured
- **Sell Locations** - Horse dealer coordinates and settings
- **Language Strings** - Customize all notification text

## Wild Horse Models

By default, these wild horse breeds can be captured:
- Mustangs (Golden Dun, Grullo Dun, Tiger Striped Bay, Wild Bay)
- Nokotas (Blue Roan, Reverse Dapple Roan, White Roan)
- Tennessee Walkers (Black Rabicano, Chestnut, Dapple Bay, Flaxen Roan, Mahogany Bay, Red Roan)

## Economy

Horses sell for 50% of their base value (configurable):
- Common horses: $5-10
- Uncommon horses: $50-75
- Rare horses: $150-250

## Dependencies

- qbr-core (required)

## Admin Commands

- `/horsestats` - Check if the horse capture system is active (admin only)

## Future Enhancements

Potential additions:
- Horse quality/stats affecting sell price
- Mini-game for taming instead of simple timer
- Database tracking of captured horses
- Reputation system with horse dealers
- Special rare horses with higher rewards
- Horse breeding mechanics

## Support

For issues or suggestions, please create an issue on the repository.

## License

This resource is part of the QBR-Core framework and follows the same GPL-3.0 license.

## Credits

Created for QBR-Core RedM framework
