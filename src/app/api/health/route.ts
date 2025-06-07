import { NextResponse } from 'next/server'
import { getPayload } from 'payload'
import config from '@/payload.config'

/**
 * Health check endpoint for Docker container health monitoring
 * This endpoint verifies that both the Next.js server and MongoDB connection are working
 */
export async function GET() {
  try {
    // Check Payload CMS and MongoDB connection
    const payload = await getPayload({ config })
    
    // Verify database connection by performing a simple query
    await payload.db.connection.collection('payload-preferences').findOne({})
    
    return NextResponse.json({ 
      status: 'healthy',
      timestamp: new Date().toISOString(),
      services: {
        api: 'up',
        database: 'connected'
      }
    }, { status: 200 })
  } catch (error) {
    console.error('Health check failed:', error)
    
    return NextResponse.json({
      status: 'unhealthy',
      timestamp: new Date().toISOString(),
      error: error instanceof Error ? error.message : 'Unknown error'
    }, { status: 503 })
  }
}
