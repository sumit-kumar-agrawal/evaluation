namespace :basket do
  desc "Add apple to basket"
  task :add_apple_to_basket, [:variety, :count] => :environment do |task, args|
    variety = args[:variety]
    count = args[:count].to_i

    baskets = Basket.left_joins(:apples).where("apples.variety = ? OR apples.id IS NULL", variety).group(:id, :capacity).order("capacity DESC")
    if baskets
      remaining_count = count
      baskets.each do |basket|
        _apples = basket.apples
        if basket.capacity > _apples.count
          # Calculate the number of apples to add to this basket
          capacity = [remaining_count, basket.capacity - _apples.count].min

          # Create the apple records for this batch
          capacity.times do |i|
            basket.apples << Apple.new(variety: variety)
          end
          basket.save
          remaining_count -= capacity
        end
        break if remaining_count <= 0
      end
      puts "All baskets are full. We couldn't find the place for #{remaining_count} apples." if remaining_count > 0
    else
      puts "We couldn't find the basket for #{count} apples"
    end
  end

end