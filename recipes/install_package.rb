# frozen_string_literal: true

packages = %w[
  gcc
  make
]

# Install required packages
case node[:platform]
when 'ubuntu'
  packages.concat %w[
    libncurses5-dev
    libxpm-dev
    libjpeg8-dev
    libgif-dev
    libtiff5-dev
  ]
  case node[:platform_version].to_i
  when 18, 24
    packages.concat %w[
      libpng-dev
      libgnutls28-dev
      texinfo
    ]
  else
    packages.concat %w[
      libpng12-dev
      libgnutls-dev
    ]
  end
  packages.each do |package|
    apt_package package do
      action :install
    end
  end
when 'centos', 'redhat', 'amazon'
  package.concat %w[
    ncurses-devel
    libXpm-devel
    libjpeg-devel
    libpng-devel
    libgif-devel
    libtiff-devel
    gnutls-devel
  ]
  yum_package package do
    action :install
  end
end
