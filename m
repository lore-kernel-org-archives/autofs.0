From: Ian Kent <raven@themaw.net>
Subject: Re: [patch] more robust test for ldap library
Date: Tue, 09 Dec 2008 15:14:09 +0900
Message-ID: <1228803249.3044.44.camel@zeus.themaw.net>
References: <49396D5B.7040405@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <49396D5B.7040405@inria.fr>
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
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-12-05 at 19:05 +0100, Guillaume Rousse wrote:
> Hello.
> 
> The test for LDAP library wrongly use LDFLAGS to add -lldap to the gcc 
> call. However, when strict linker ordering is in effect, it doesn't work 
> correctly. As described in autoconf documentation, additional libs 
> should be added through LIBS variable instead. The following patch fixes it.

Committed to git and posted to kernel.org.

Thanks
Ian
