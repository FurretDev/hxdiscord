package hxdiscord.types;

import hxdiscord.DiscordClient;
import hxdiscord.types.structTypes.*;
import hxdiscord.endpoints.Endpoints;

class Interaction
{
    public var username:String;
    public var public_flags:Int;
    public var id:String;
    public var discriminator:String;
    public var avatar_decoration:Dynamic;
    public var avatar:String;
    public var user:UserS;
    public var channel_id:String;
    public var name:String;
    public var member:hxdiscord.types.structTypes.InteractionS.Member;
    public var intId:String;
    public var wasThinking:Bool = false;
    public var guild_id:String;
    public var components:Array<Dynamic>;
    public var options:Array<Dynamic>;
    public var dataOptions:Dynamic;
    public var type:Int;
    public var token:String;
    public var data:hxdiscord.types.structTypes.InteractionS.InteractionData;
    public var channel:Channel;
    public var locale:String;
    public var entitlements:Array<Dynamic>;
    public var version:Int;
    public var authorizing_integration_owners:Dynamic;
    public var context:Int;

    /**
        Constructor (You won't probably use this since it's useless to construct one)
        @param ins The interaction object
        @param _client The client instance you're running
        @param parsedJSON Same thing as the interaction object but as a Dynamic object, don't ask why I did that
    **/

    public function new(ins:InteractionS, _client:DiscordClient, parsedJSON:Dynamic)
    {
        trace("intermediate logging");
        channel = ins.channel;
        trace("intermediate logging");
        locale = ins.locale;
        trace("intermediate logging");
        entitlements = ins.entitlements;
        trace("intermediate logging");
        version = ins.version;
        trace("intermediate logging");
        authorizing_integration_owners = ins.authorizing_integration_owners;
        trace("intermediate logging");
        context = ins.context;
        trace("intermediate logging");
        username = ins.username;
        trace("intermediate logging");
        public_flags = ins.public_flags;
        trace("intermediate logging");
        id = ins.id;
        trace("intermediate logging");
        discriminator = ins.discriminator;
        trace("intermediate logging");
        avatar_decoration = ins.avatar_decoration;
        trace("intermediate logging");
        user = ins.user;
        trace("intermediate logging");
        /**
            Discord I fucking hate you for adding pomelo
        **/
        /**if (discriminator == "0") {
            ins.user.username_f = username;
        } else {
            ins.user.username_f = '${username}#${discriminator}';
        }**/
        member = ins.member;
        trace("intermediate logging");
        //trace(member);
        trace("intermediate logging");
        avatar = ins.avatar;
        trace("intermediate logging");
        channel_id = ins.channel_id;
        trace("intermediate logging");
        guild_id = ins.guild_id;
        trace("intermediate logging");
        name = ins.name;
        trace("intermediate logging");
        intId = ins.intId;
        trace("intermediate logging");
        components = ins.components;
        trace("intermediate logging");
        options = ins.options;
        trace("intermediate logging");
        type = ins.type;
        trace("intermediate logging");
        token = ins.token;
        trace("intermediate logging");
        data = ins.data;
        trace("intermediate logging");

        if (this.options != null)
        {
            dataOptions = this.options[0];
        }
        else
        {
            dataOptions = {
                type: 3,
                name: "no_options",
                value: "no_options"
            };
        }
    }

    /**
        Reply to the interaction
        @param ic The interaction object
        @param ephemeral Whether it's an ephemeral message or not (Only visible to the user interacting)
    **/

    public function reply(ic:hxdiscord.types.Typedefs.InteractionCallback, ?ephemeral:Bool)
    {
        if (wasThinking) {
            try {
                Endpoints.editInteractionResponse(ic, token);
            }
        } else {
            Endpoints.sendInteractionCallback(ic, intId, token, 4, ephemeral);
        }
    }

    /**
        Edits the interaction respond if it's called by a component
        @param ic The interaction object
    **/
    public function editComponent(ic:hxdiscord.types.Typedefs.InteractionCallback)
    {
        Endpoints.sendInteractionCallback(ic, intId, token, 7);
    }

    /**
        Shows a modal
        @param title The modal title
        @param custom_id The custom id of the modal
        @param imc An array full of action rows
    **/
    public function showModal(title:String, custom_id:String, imc:Array<hxdiscord.types.message.ActionRow>)
    {
        Endpoints.showInteractionModal(imc, intId, token, type, title, custom_id);
    }

    /**
        Returns a value from the interaction options
        @param optionName The name of the option
    **/
    public function getValue(optionName:String):Dynamic
    {
        var daThing:Dynamic = "optionName";

        if (this.options != null)
        {
            for (int in this.options)
            {
                if (int.name == optionName)
                {
                    daThing = int.value;
                }
            }
        }
        else
        {
            daThing = null;
        }
        return daThing;
    }

    /**
        Edits the interaction response
        @param ic The interaction object
    **/

    /**
        Make the bot "think". This will show as "Bot is thinking..."
    **/

    public function think() {
        Endpoints.makeInteractionThink(intId, token);
        wasThinking = true;
    }

    public function edit(ic:Typedefs.InteractionCallback)
    {
        try { //if it works leave it like that™️
            Endpoints.editInteractionResponse(ic, token);
        }
    }
}
