From: raven@themaw.net
Subject: RE: csh/cd not getting the right cwd at the mount point
Date: Tue, 13 Jul 2004 19:24:17 +0800 (WST)
Sender: autofs-bounces@linux.kernel.org
Message-ID: <Pine.LNX.4.58.0407131921270.1375@donald.themaw.net>
References: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <BA0E4392AD99D040885C414D992C24BE08264BD4@us-bv-m11.bv.tek.com>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peter.a.harris@exgate.tek.com
Cc: autofs@linux.kernel.org

On Mon, 12 Jul 2004 peter.a.harris@exgate.tek.com wrote:

> Ian/Jeff,
> 
> I just tried your test below and I **was** able to touch the file
> successfully, even though I was seeing my problem.  The problem I am seeing
> seems to be limited to what the system thinks is the cwd.  Let me try to
> restate the problem...

OK. The problem you report is clearer to me now.

I must re-interate that the versions in your initial report were old.

I will try to reproduce this but I remember Jeff saying he was unable to 
reproduce it with his current autofs.

Ian
