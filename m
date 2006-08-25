From: Ian Kent <raven@themaw.net>
Subject: Re: autofs 5.0.1-rc1 still doesn't find master map in	ldap
	automatically
Date: Fri, 25 Aug 2006 21:25:09 +0800
Message-ID: <1156512309.30971.14.camel@raven.themaw.net>
References: <44EDB98B.8050201@inria.fr>
	<Pine.LNX.4.64.0608250923480.6382@raven.themaw.net>
	<44EEA538.8090203@inria.fr>
	<Pine.LNX.4.64.0608251920210.30523@raven.themaw.net>
	<44EEEC55.2040101@inria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <44EEEC55.2040101@inria.fr>
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

On Fri, 2006-08-25 at 14:25 +0200, Guillaume Rousse wrote:
> Ian Kent wrote:
> >> I'll try to run it in the debugger, but I have to fix my debug package
> >> first.
> gdbdoesn't complain anymore about missing symbols, but despite my
> attempts, I've been unable to set a working break point on faulty
> function (get_query_dn).
> 
> > Can you give a couple of examples of you LDAP entries please.
> Here it is:

This looks OK.
I wonder what could be causing this unusual problem.

Ian
