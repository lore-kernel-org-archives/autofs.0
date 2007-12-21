From: Mike Marion <mmarion@qualcomm.com>
Subject: Re: Seeing autofs-5.0.2 core dumping
Date: Fri, 21 Dec 2007 13:50:16 -0800
Message-ID: <20071221215016.GE29941@cornholio.qualcomm.com>
References: <20071221023024.GB10904@cornholio.qualcomm.com>
	<1198236856.3488.11.camel@raven.themaw.net>
	<20071221192744.GA14860@cornholio.qualcomm.com>
	<20071221211259.GC29941@cornholio.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
In-Reply-To: <20071221211259.GC29941@cornholio.qualcomm.com>
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

On Fri, Dec 21, 2007 at 01:13:00PM -0800, Mike Marion wrote:

> Setting up a debug log and going to strace daemon at same time.

Gah.. haven't seen a repeat on that with multiple restart and reboots
though.  

Fixed what I mentioned about debug logging too.. turns out I'm a doofus
and missed that we weren't specifically loggin daemon.debug on all
hosts.  *smack*

About to debug log a case where we (which is easy to reproduce) the HUP
triggering the umounted direct mount.. issue.

-- 
Mike Marion-Unix SysAdmin/Staff IT Engineer-http://www.qualcomm.com
Sorry, please try again. Thank you for taking the Turing test.
