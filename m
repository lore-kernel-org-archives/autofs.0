From: Ian Kent <raven@themaw.net>
Subject: Re: patch: explicitely link against kerberos libs for	sasl
	support
Date: Sun, 18 Nov 2007 11:24:28 +0900
Message-ID: <1195352668.3087.3.camel@raven.themaw.net>
References: <473EDD53.3060303@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <473EDD53.3060303@inria.fr>
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
Cc: autofs@linux.kernel.org

On Sat, 2007-11-17 at 13:23 +0100, Guillaume Rousse wrote:
> sasl support breaks ldap module for unresolved kerberos symbols.
> Attached patch fix this issue by explicitely linking against kerberos libs.

Thanks Guillaume.
I think there's something else not quite right with this as well.
I'll test and fix this when I look at that issue.

Ian
