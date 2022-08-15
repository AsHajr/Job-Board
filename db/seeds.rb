# seed 50 records
50.times do
  job = Job.create(title: Faker::Lorem.word, description: Faker::Lorem.word,created_by: User.first.id)
  job.jobapps.create(created_by: User.last.id)
end