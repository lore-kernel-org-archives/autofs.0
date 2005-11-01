From: Ian Kent <raven@themaw.net>
Subject: Re: autofs timeout and large map
Date: Wed, 2 Nov 2005 00:07:16 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511020005090.3040@donald.themaw.net>
References: <20051028163028.75072c9b.akpm@osdl.org> 
	<Pine.LNX.4.63.0510291032450.2075@donald.themaw.net> 
	<89e9feae0510310904u389dc003mc311a1f0a1058168@mail.gmail.com>
	<89e9feae0511010451we3f1d43g8c8d3caf0efceb0@mail.gmail.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <89e9feae0511010451we3f1d43g8c8d3caf0efceb0@mail.gmail.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dannie Stanley <dannie.stanley@gmail.com>
Cc: autofs@linux.kernel.org

On Tue, 1 Nov 2005, Dannie Stanley wrote:

> I performed some testing in the early morning hours and this is what I
> found.  The problem seems to be with the --ghost option.  When I
> specify this in my auto.master:
> 
>    /- /etc/auto.virtual --ghost
> 
> I get the originally reported errors.  When I remove the --ghost
> option it seems to work as expected.
> 

Btw there are two kernel modules, autofs and autofs4, which do you have 
loaded?

You can find out with an lsmod. You'll see either autofs or autofs4.

Ian
