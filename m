From: Ian Kent <raven@themaw.net>
Subject: Re: autofs to load MAP from LDAP
Date: Thu, 09 Nov 2006 19:38:34 +0800
Message-ID: <1163072315.7831.14.camel@localhost>
References: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
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
To: Syed Khader <syedk@google.com>
Cc: autofs@linux.kernel.org

On Thu, 2006-11-09 at 10:49 +0530, Syed Khader wrote:

> 
> /usr/lib/autofs/autofs-ldap-auto-master DOESn't give any ouput 

As we established, we need to find out why this program (the one that
reads the LDAP master map) is not receiving anything back from the LDAP
server.

You will need to either increase the debug level on the LDAP server to
log packets or obtain a network packet dump of the network communication
to the server from the client.

Something like:

tcpdump -w <file to save packets to> host <LDAP server name or IP>

on the client should do it. Then we need to get hold of it somehow.

Ian
