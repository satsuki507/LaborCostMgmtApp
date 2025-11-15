import NextAuth from "next-auth";
import { PrismaAdapter } from "@next-auth/prisma-adapter";
import { PrismaClient } from "@prisma/client";
import CredentialsProvider from "next-auth/providers/credentials";
import bcrypt from "bcryptjs";

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
                if (!credentials?.email || !credentials?.password) {
                    return null; // 資格情報が不足
                }

                // 1. ユーザーをDBから検索
                const user = await prisma.user.findUnique({
                    where: { email: credentials.email },
                });

                // ユーザーが存在しない、またはパスワードが設定されていない場合
                if (!user || !user.password) {
                    return null;
                }

                // 2. パスワードの比較
                const isPasswordValid = await bcrypt.compare(
                    credentials.password,
                    user.password // DBに保存されているハッシュ化されたパスワード
                );

                if (isPasswordValid) {
                    // 認証成功: ユーザーオブジェクトを返す
                    return {
                        id: user.id,
                        email: user.email,
                        // 必要に応じて name などの情報も含める
                    };
                } else {
                    // 認証失敗
                    return null;
                }
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
