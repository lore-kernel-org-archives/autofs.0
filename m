From: "Cyril B." <cbay@excellency.fr>
Subject: Re: [PATCH] Add a --mode option to chmod the mount point of the maps
Date: Mon, 14 Sep 2015 12:12:50 +0200
Message-ID: <55F69DA2.7060204@excellency.fr>
References: <55F58085.4090509@excellency.fr>  <1442197882.3030.33.camel@themaw.net> <55F68878.40803@excellency.fr> <1442223945.3030.64.camel@themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=excellency.fr; s=default;
	h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Subject:CC:To:MIME-Version:From:Date:Message-ID; bh=mSEmlhIbu3rUD9535lR1KHIRNNiwOY8PVQ58ymH5+8I=;
	b=DrxVXsCfCvky4uB8cbrhLgsa5bpULI3cVLAE2jfrNDzMoS/K1oYq5oOzAD3wmehYkHT+nB6te98xBQKCpxteDOTze5BnIyMuUys/JrJ6Y6OF1HXqMD9OeSAIJpWaj1dBrN9G4mwawSMqSdjGardkAj2RhB3YohayyWd2eHqMBXrJygI5lMooXiHzq0Gyh1f47J4jin473kEUsYSSSnEk1rlCvzUr/iLKEvkbVPk5ASlZtGqdpy2gnwMCiv8FwvWhhpU7mQVPhbQx/a4e+5RPMbexa4ZOwuqHrc51E6N4YVwcTr0ddA3EaMa8LaNvW0bgs66pueWhLCZaiAvIq6lXUw==;
In-Reply-To: <1442223945.3030.64.camel@themaw.net>
Sender: autofs-owner@vger.kernel.org
List-ID: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Ian Kent <raven@themaw.net>
Cc: "autofs@vger.kernel.org" <autofs@vger.kernel.org>

Ian Kent wrote:
> So are you saying you don't have sufficient faith in the permissions set
> on the file systems your mounting, that contain the information you want
> to protect, that you must have the permissions of an intermediate file
> system set to ensure that information about that vulnerability is not
> seen?

I do know that there's no vulnerability at all, and that you can 
trivially list users by other means.

Unfortunately, some of my less tech savvy users believe that there's a 
vulnerability because they can see other accounts' home directories, and 
thus feel that their own files are not safe. Is this stupid? absolutely. 
But changing my /home permissions to 751 makes those users happy and 
saves my time -- and my reputation as a sysadmin :)

I also do realize that the 755 permissions come from the autofs kernel 
filesystem itself. But the kernel doesn't support a 'mode' option for 
autofs (some other file systems do), and even if it did, autofs would 
have to be patched to support it (in a slightly different way than my 
current patch).

I understand that my use case may be a corner case, and I'm perfectly 
fine with keeping my patch in my own tree. I figured that since I had 
written the patch for myself anway, I may as well post it here as it 
could be useful for others :)

Thanks!

-- 
Cyril B.
--
To unsubscribe from this list: send the line "unsubscribe autofs" in
