import NextAuth from "next-auth";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import { PrismaClient } from "@prisma/client";
import CredentialsProvider from "next-auth/providers/credentials";

const prisma = new PrismaClient();

export const authOptions = {
    // 1. アダプター: データベース連携
    adapter: PrismaAdapter(prisma),

    // 2. プロバイダー: 認証方法 (クレデンシャル認証を優先)
    providers: [
        CredentialsProvider({
            name: "Credentials",
            credentials: {
                /* ログインフォームの入力フィールドを定義 */
                email: { label: "Email", type: "text" },
                password: { label: "Password", type: "password" },
            },
            async authorize(credentials, req) {
                // ここに、DBからユーザーを取得し、パスワードを検証する
                // 成功すれば user オブジェクトを返し、失敗すれば null を返す
                // このロジックは、このフェーズの次のステップで実装します。
                return null; // 一旦は null または ダミー
            },
        }),
        // GoogleなどのOAuthプロバイダーをここに追加できる
    ],

    // 3. セッション: JWT戦略を強制
    session: {
        strategy: "jwt" as const, // JWT (JSON Web Token) ベースのセッション管理を強制
    },

    // 4. その他のセキュリティ関連
    secret: process.env.NEXTAUTH_SECRET, // 環境変数からシークレットキーを取得
};

export default NextAuth(authOptions);
