import { withPayload } from '@payloadcms/next/withPayload'

/** @type {import('next').NextConfig} */
const nextConfig = {
  // Enable standalone output for Docker deployment
  output: 'standalone',
  
  // Disable image optimization during development if needed
  images: {
    unoptimized: process.env.NODE_ENV !== 'production',
  },
}

export default withPayload(nextConfig, { devBundleServerPackages: false })
