import React, { createContext, useContext, useEffect, useState } from 'react';
import SockJS from 'sockjs-client';
import Stomp from 'stompjs';
import { useAuth } from './AuthContext';

const SocketContext = createContext(null);

export const SocketProvider = ({ children }) => {
    const { user } = useAuth();
    const [stompClient, setStompClient] = useState(null);
    const [connected, setConnected] = useState(false);

    useEffect(() => {
        let mounted = true;
        if (user && user.token) {
            const socket = new SockJS('http://localhost:8080/ws');
            const client = Stomp.over(socket);
            client.debug = null;

            client.connect({}, () => {
                if (mounted) {
                    setConnected(true);
                    setStompClient(client);
                    console.log('Connected to WebSocket');
                }
            }, (error) => {
                if (mounted) {
                    console.error('WebSocket connection error:', error);
                    setConnected(false);
                }
            });

            return () => {
                mounted = false;
                if (client && client.connected) {
                    try {
                        client.disconnect();
                    } catch (e) {
                        console.warn('Socket disconnect warning:', e);
                    }
                }
            };
        }
    }, [user]);

    return (
        <SocketContext.Provider value={{ stompClient, connected }}>
            {children}
        </SocketContext.Provider>
    );
};

export const useSocket = () => useContext(SocketContext);
