// AWS API Gateway / Amplify接続時に実装します。
// mockApiと同じ listEvents(locale) 契約を保ってください。
export const realApi = {
  async listEvents() {
    throw new Error('Real API is not configured.')
  }
}
