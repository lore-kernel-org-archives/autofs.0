From: ramana <ramana@intraperson.com>
Subject: Re: automount hung
Date: Sun, 20 Mar 2005 19:52:02 +0530
Message-ID: <423D870A.7070307@intraperson.com>
References: <423B33E0.3020109@bnl.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <423B33E0.3020109@bnl.gov>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org
Cc: Sev Binello <sev@bnl.gov>

Sev Binello wrote:
> 
> Has anyone had the experience where the automount daemon seems to freeze ?
> It will not expire anything, nor mount anything new ?
> 
> 

When it is freezing?

It is something to do with applications which are terminated while they are accessing autofs directories -- using signals for example?

Regards
ramana

-- 
http://www.intraperson.com
