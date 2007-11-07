From: Dan Halbert <halbert@everyzing.com>
Subject: Re: ENOENT on first reference to an automounted file
Date: Tue, 06 Nov 2007 20:53:55 -0500
Message-ID: <47311AB3.6070305@everyzing.com>
References: <mailman.1.1192795201.25176.autofs@linux.kernel.org>
	<6766EDC4-0232-4304-B753-64A2E4C2898E@isolar.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <6766EDC4-0232-4304-B753-64A2E4C2898E@isolar.dyndns.org>
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
To: autofs@kernel.org

Greg Earle wrote:
> We use NIS for our maps, but just for fun, I decided to test
> turning "--ghost" *on* (we default to it off, and we also use
> "-nobrowse" on our Suns, so we like to keep them consistent),
> and ...
>   
Greg, try the latest kernel, 2.6.9-55.0.12, which is now available from 
RedHat and has also gone downstream to various other RH-source-based 
distributions. This works for us. I agree your ghost/non-ghost 
differences are odd and do not match my experience. But I see 
differences also based on client load.

Dan
