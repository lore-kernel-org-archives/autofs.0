From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: To autofs4 or not
Date: Mon, 19 Apr 2004 22:18:02 -0700
Sender: autofs-bounces@linux.kernel.org
Message-ID: <4084B28A.4040105@zytor.com>
References: <407F1FBC.3060603@analog.com>
	<16511.61489.172219.152402@segfault.boston.redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <16511.61489.172219.152402@segfault.boston.redhat.com>
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
To: jmoyer@redhat.com
Cc: autofs@linux.kernel.org

Jeff Moyer wrote:
> ==> Regarding [autofs] To autofs4 or not; "Alan.Burke" <alan.burke@analog.com> adds:
> 
> alan.burke> Hi Everyone, I have the task of convincing a team of admins
> alan.burke> that we should be using autofs4 with RH8. /net is the major
> alan.burke> reason I want to use it, but some claim RH does not support
> alan.burke> autofs4. Is this true? If so will they support it in RHE3 or a
> alan.burke> future version?
> 
> Well, RH8 is no longer supported, I'm sure you know.  :(  I've been working
> to get the autofs4 user space into RHEL 3, so it will appear in the next
> update release.  RHEL 4 will _hopefully_ support autofs4 user space and
> kernel module.
> 

For what it's worth, it seems autofs 4 has gotten stable enough, and 
autofs 3 has bitrotted enough :-/ that I'm not planning to make any more 
autofs 3 releases unless something major happens.

	-hpa
