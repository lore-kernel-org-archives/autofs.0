From: Risto Bell <reb@cypress.com>
Subject: Re: autofs Digest, Vol 43, Issue 12
Date: Tue, 31 Oct 2006 09:43:54 -0800
Message-ID: <45478B5A.7000106@cypress.com>
References: <mailman.1.1162296001.31020.autofs@linux.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <mailman.1.1162296001.31020.autofs@linux.kernel.org>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: autofs@linux.kernel.org

 > My system defaults to tcp nfs v3 if no options are specified.

How does one achieve/config that (Solaris like) in autofs4?
Likewise achieving the NETAPP recommended TCP options timeo=600,retrans=2

If you have mix of servers, some only supporting UDP, but wish
to prefer TCPv3 whereever it's available and UDP only if no choice...

I use scripts programs (like auto.net), that do rpcinfo
to test if the server supports TCP and add the options. But even
emulating NIS look-ups, overall result (scripts) are considerably
slower.
