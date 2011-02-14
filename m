From: Steve Thompson <smt@vgersoft.com>
Subject: Re: Wrong network
Date: Mon, 14 Feb 2011 14:22:05 -0500 (EST)
Message-ID: <alpine.LRH.0.9999.1102141420430.25310@firefly.vgersoft.com>
References: <alpine.LRH.0.9999.1102120924290.6851@helios.vgersoft.com>
	<alpine.LRH.0.9999.1102121518420.12882@helios.vgersoft.com>
	<1297649183.2822.6.camel@perseus>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1297649183.2822.6.camel@perseus>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/options/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs/>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org

On Mon, 14 Feb 2011, Ian Kent wrote:

> That is the way it should work but dns round robin entries like this
> aren't handled quite correctly.
>
> I'm not sure this patch will apply (the CHANGELOG hunk certainly won't)
> but you could try it:

Unfortunately I am not able to try this - I can use only the .rpm's that 
come from the CentOS repo. Hopefully this patch will make it upstream 
soon, given the seriousness of this issue.

Steve
