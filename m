From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: ghost
Date: Fri, 12 Mar 2004 20:40:39 -0800
Sender: autofs-bounces@linux.kernel.org
Message-ID: <405290C7.8090305@zytor.com>
References: <1079118752.4320.10.camel@jade.biology.duke.edu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1079118752.4320.10.camel@jade.biology.duke.edu>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Hunter Matthews <thm@duke.edu>
Cc: autofs@linux.kernel.org

Hunter Matthews wrote:
> I've not seen a lot of mention of it, but I've been very happy with 
> the ghost option and autofs-4.1.0-2 here. I've tried it with both NIS 
> and LDAP fed maps (old schema) and it seems to work fine. 
> 
> For my users, I'd love to see --ghost the default in the future.

It shouldn't be the default (put it in your maps, though.)  It requires 
an expensive enumeration operation.

	-hpa
