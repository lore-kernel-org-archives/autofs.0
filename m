From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: 
 Autofs and unrecognized parameters... mount() not ignoring anymorefor
 2.6 kernel?
Date: Fri, 3 Sep 2004 15:35:44 -0400
Sender: autofs-bounces@linux.kernel.org
Message-ID: <16696.51088.808597.401614@segfault.boston.redhat.com>
References: <4138C5A3.10107@deragon.biz>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4138C5A3.10107@deragon.biz>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"
To: Hans Deragon <hans@deragon.biz>
Cc: autofs@linux.kernel.org

==> Regarding [autofs]  Autofs and unrecognized parameters... mount() not ignoring anymorefor 2.6 kernel?; Hans Deragon <hans@deragon.biz> adds:

hans> Greetings.  I use the same source code for two systems, RHL 9 and
hans> FC2.  Its Autofs 4.1.3 with my infamous backfstype patch.

hans>    RHL 9 runs kernel 2.4.20-28.9 while FC2 runs 2.6.6-1.435.  On RHL
hans> 9, autofs runs nicely.  On FC2, it complains about unrecognized
hans> parameters.  This happens when I try to mount from yp maps that are
hans> meant for Solaris.

hans>    Is this a known issue?  Seams that the mount function does not
hans> ignore unrecognized parameters anymore under the 2.6 kernel.

Yes, known issue.  Upgrade util-linux.

-Jeff
